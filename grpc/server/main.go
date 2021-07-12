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

type connection struct {
	name       string
	host       string
	port       string
	driver     string
	socket     bool
	socket_dir string
	user       string
	password   string
}

// DB methods
func getDriver(dbType string) string {
	var driver string
	switch dbType {
	case "postgres":
		driver = "pgx"
	case "sqlite":
		driver = "sqlite"
	default:
		log.Fatalf("Unsupported database: %s", dbType)
	}
	return driver
}

func initConn(connection connection, safeConn bool) {
	log.Println("Initializing connection to database...")
	var dbUri string

	if safeConn {
		switch connection.driver {
		case "sqlite":
			dbUri = fmt.Sprintf("/tmp/%s.db", connection.name)
		case "pgx":
			dbUri = fmt.Sprintf(
				"postgres://%s:%s@%s:%s/",
				connection.user,
				connection.password,
				connection.host,
				connection.port)
		}
		if connection.socket {
			dbUri = fmt.Sprintf(
				"%s:%s@unix(/%s/%s)/?parseTime=true",
				connection.user,
				connection.password,
				connection.socket_dir,
				connection.host)
		}
	} else {
		switch connection.driver {
		case "sqlite":
			dbUri = fmt.Sprintf("/tmp/%s.db%s", connection.name, connection.name)
		case "pgx":
			dbUri = fmt.Sprintf(
				"postgres://%s:%s@%s:%s/%s",
				connection.user,
				connection.password,
				connection.host,
				connection.port,
				connection.name)
		}
		if connection.socket {
			dbUri = fmt.Sprintf(
				"%s:%s@unix(/%s/%s)/%s?parseTime=true",
				connection.user,
				connection.password,
				connection.socket_dir,
				connection.host,
				connection.name)
		}
	}

	log.Printf("Connecting via DB URI: %s...", dbUri)
	db, err := sql.Open(connection.driver, dbUri)
	if err != nil {
		log.Fatal(err)
	}
	DB = db
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

// Batch methods
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

// Standard methods
func (s *server) Get(ctx context.Context, in *server_proto.LinkRequest) (*link_proto.Link, error) {
	var (
		name       string
		target_url string
		views      int64
	)

	log.Printf("Received Get request: %s", in)
	err := DB.QueryRow(
		"SELECT name, target_url, views FROM links WHERE name=$1",
		in.Name).Scan(&name, &target_url, &views)
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
		 DO UPDATE SET target_url = $2, views = $3;`,
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

func main() {
	dbNameFlag := flag.String("db_name", "gohome", "Database name.")
	dbHostFlag := flag.String("db_host", "", "Database host name.")
	dbPortFlag := flag.String("db_port", "5432", "Port for database connection.")
	dbUserFlag := flag.String("db_user", "", "User for DB access.")
	dbPasswordFlag := flag.String("db_password", "", "Password for DB access.")
	dbSocketDirFlag := flag.String("socket_dir", "", "UNIX socket name.")
	dbTypeFlag := flag.String(
		"db_type",
		"sqlite",
		"Database type (sqlite and postgres are supported).")
	dbSocketFlag := flag.Bool(
		"use_socket",
		false,
		"Use UNIX sockets for DB connections.")
	envCredFlag := flag.Bool(
		"use_env_credentials",
		false,
		"Get credentials from environment variables (GOHOME_PASSWORD).")
	flag.Parse()

	// Init connection
	connection := connection{
		name:       *dbNameFlag,
		host:       *dbHostFlag,
		port:       *dbPortFlag,
		driver:     getDriver(*dbTypeFlag),
		socket:     *dbSocketFlag,
		socket_dir: *dbSocketDirFlag,
		user:       *dbUserFlag,
		password:   *dbPasswordFlag,
	}

	if *envCredFlag {
		connection.password = os.Getenv("GOHOME_PASSWORD")
	}

	// Perform initial setup, if necessary
	ctx := context.Background()
	initConn(connection, true)
	initDb(ctx, connection.name)
	initTable()

	// Establish DB connection
	initConn(connection, false)
	defer DB.Close()

	// Set server port
	port := os.Getenv("PORT")
	if port == "" {
		log.Printf("No default port set, using 50051...")
		port = "50051"
	}

	// Start gRPC server
	log.Printf("Starting GoHome gRPC server on port %s...", port)
	serverPort := fmt.Sprintf(":%s", port)
	lis, err := net.Listen("tcp", serverPort)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	s := grpc.NewServer()
	server_proto.RegisterGoHomeServer(s, &server{})

	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
