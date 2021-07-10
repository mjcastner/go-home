package main

import (
	"context"
	"database/sql"
	"flag"
	"fmt"
	"log"
	"net"
	"os"
	"strings"

	_ "github.com/jackc/pgx/stdlib"
	link_proto "github.com/mjcastner/go-home/protos/link_proto_go"
	server_proto "github.com/mjcastner/go-home/protos/server_proto_go"
	"google.golang.org/grpc"
	_ "modernc.org/sqlite"
)

var DB *sql.DB

type server struct {
	server_proto.UnimplementedGoHomeServer
}

func (s *server) BatchGet(ctx context.Context, in *server_proto.LinkRequestBatch) (*server_proto.LinkBatch, error) {
	log.Printf("Received Batch Get request: %s", in)
	var (
		name       string
		target_url string
		views      int64
	)

	links := &server_proto.LinkBatch{}
	rows, err := DB.Query("SELECT name, target_url, views FROM links LIMIT 500;")
	if err != nil {
		log.Println(err)
	}

	for rows.Next() {
		rows.Scan(&name, &target_url, &views)
		link := &link_proto.Link{
			Name:      name,
			TargetUrl: target_url,
			Views:     views,
		}
		links.Links = append(links.Links, link)
	}

	return links, nil
}

func (s *server) Get(ctx context.Context, in *server_proto.LinkRequest) (*link_proto.Link, error) {
	var (
		name       string
		target_url string
		views      int64
	)

	log.Printf("Received Get request: %s", in)
	err := DB.QueryRow("SELECT name, target_url, views FROM links WHERE name=$1", in.Name).Scan(&name, &target_url, &views)
	if err != nil {
		log.Println(err)
	}

	link := &link_proto.Link{
		Name:      name,
		TargetUrl: target_url,
		Views:     views,
	}
	return link, nil
}

func (s *server) Set(ctx context.Context, in *link_proto.Link) (*server_proto.SetResponse, error) {
	log.Printf("Received Set request for key %s: %s", in.Name, in.TargetUrl)

	_, err := DB.Exec(
		`INSERT INTO
			 links (name, target_url, views)
		 VALUES ($1, $2, $3)
		 ON CONFLICT (name)
		 DO UPDATE SET target_url = $2;`,
		in.Name,
		in.TargetUrl,
		in.Views,
	)
	if err != nil {
		log.Println(err)
		response := &server_proto.SetResponse{
			Code: 1,
		}
		return response, err
	} else {
		response := &server_proto.SetResponse{
			Code: 0,
		}
		return response, nil
	}
}

func initDb(ctx context.Context, dbName string) bool {
	log.Println("Initializing database...")
	initDbSmt := fmt.Sprintf("CREATE DATABASE %s;", dbName)
	_, err := DB.Exec(initDbSmt)
	if err != nil {
		if strings.Contains(err.Error(), "already exists") {
			log.Printf("Using existing %s database", dbName)
			return true
		} else {
			log.Printf("%s: %s", err, initDbSmt)
			return false
		}
	}

	log.Printf("Successfully initialized %s database", dbName)
	return true
}

func initTable() {
	initStmt := `
		CREATE TABLE IF NOT EXISTS links (
			name VARCHAR ( 50 ) PRIMARY KEY,
			target_url VARCHAR ( 255 ),
			views BIGINT
		);
	`
	_, err := DB.Exec(initStmt)
	if err != nil {
		log.Printf("%q: %s\n", err, initStmt)
	}
}

func main() {
	dbNameFlag := flag.String("db_name", "gohome", "Database name.")
	dbTypeFlag := flag.String("db_type", "sqlite", "Database type (sqlite and postgres are supported).")
	dbHostFlag := flag.String("db_host", "", "Database host name.")
	dbUserFlag := flag.String("user", "", "User for DB access.")
	dbPasswordFlag := flag.String("password", "", "Password for DB access.")
	flag.Parse()

	// Look for Cloud SQL instance connection variable
	dbHostEnvVar := os.Getenv("GOHOME_DB_HOST")
	if *dbHostFlag == "" && dbHostEnvVar != "" {
		log.Printf("Found Cloud SQL instance name: %s", dbHostEnvVar)
		dbHostFlag = &dbHostEnvVar
	}

	dbPasswordEnvVar := os.Getenv("GOHOME_DB_PASSWORD")
	if *dbPasswordFlag == "" && dbPasswordEnvVar != "" {
		dbPasswordFlag = &dbPasswordEnvVar
	}

	// Init DB connection
	ctx := context.Background()
	var dbDriver string
	var dbHostUrl string
	if *dbTypeFlag == "sqlite" {
		log.Println("Initializing connection to SQLite DB...")
		dbDriver = "sqlite"
		dbHostUrl = fmt.Sprintf("/tmp/%s.db", *dbNameFlag)
	} else if *dbTypeFlag == "postgres" {
		log.Println("Initializing connection to Postgres DB...")
		dbDriver = "pgx"
		dbHostUrl = fmt.Sprintf("postgres://%s:%s@%s:5432/", *dbUserFlag, *dbPasswordFlag, *dbHostFlag)
	}
	log.Printf("Connecting to %s DB at %s...", *dbTypeFlag, dbHostUrl)
	db, err := sql.Open(dbDriver, dbHostUrl)
	if err != nil {
		log.Fatal(err)
	}
	DB = db
	defer db.Close()
	defer DB.Close()

	// Init root DB / table
	if *dbTypeFlag != "sqlite" {
		db.Ping()
		dbReady := initDb(ctx, *dbNameFlag)
		if dbReady {
			initializedUrl := fmt.Sprintf("%s%s", dbHostUrl, *dbNameFlag)
			log.Println(initializedUrl)
			db, err := sql.Open(dbDriver, initializedUrl)
			if err != nil {
				log.Fatal(err)
			}
			DB = db
		} else {
			log.Fatal("Failed to initialize DB!")
		}
	}
	initTable()

	// Set server port
	port := os.Getenv("PORT")
	if port == "" {
		log.Printf("No default port set, using 50051...")
		port = "50051"
	}
	var serverPort strings.Builder
	serverPort.WriteString(":")
	serverPort.WriteString(port)

	log.Printf("Starting GoHome gRPC server on port %s...", port)
	lis, err := net.Listen("tcp", serverPort.String())
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	s := grpc.NewServer()
	server_proto.RegisterGoHomeServer(s, &server{})

	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
