package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"net"
	"os"
	"strings"

	link_proto "github.com/mjcastner/go-home/protos/link_proto_go"
	server_proto "github.com/mjcastner/go-home/protos/server_proto_go"
	"google.golang.org/grpc"
	_ "modernc.org/sqlite"
)

var DB *sql.DB

type server struct {
	server_proto.UnimplementedGoHomeServer
}

func (s *server) Get(ctx context.Context, in *server_proto.LinkRequest) (*link_proto.Link, error) {
	var (
		name       string
		target_url string
		views      int64
	)

	log.Printf("Received Get request: %s", in)
	row := DB.QueryRow("SELECT * FROM gohome_links WHERE name=?", in.Name)
	row.Scan(&name, &target_url, &views)

	link := &link_proto.Link{
		Name:      name,
		TargetUrl: target_url,
		Views:     views,
	}
	return link, nil
}

func (s *server) Set(ctx context.Context, in *link_proto.Link) (*server_proto.SetResponse, error) {
	var (
		setStmt strings.Builder
	)
	log.Printf("Received Set request: %s", in)

	setStmt.WriteString(`
		INSERT INTO 
			gohome_links (name, target_url, views)
		VALUES `)

	setStmt.WriteString(fmt.Sprintf("('%s', '%s', %d)", in.Name, in.TargetUrl, in.Views))
	setStmt.WriteString(`
		ON CONFLICT (name)
		DO UPDATE SET target_url = '`)
	setStmt.WriteString(in.TargetUrl)
	setStmt.WriteString("';")
	_, err := DB.Exec(setStmt.String())
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

func initDb() {
	initStmt := `
		CREATE TABLE IF NOT EXISTS gohome_links (
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
	// Init SQLite
	db, err := sql.Open("sqlite", "/tmp/gohome.db")
	if err != nil {
		log.Fatal(err)
	}
	DB = db
	initDb()
	defer db.Close()
	defer DB.Close()

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
