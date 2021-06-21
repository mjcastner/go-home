package main

import (
	"context"
	"crypto/tls"
	"flag"
	"log"
	"reflect"

	link_proto "github.com/mjcastner/go-home/protos/link_proto_go"
	server_proto "github.com/mjcastner/go-home/protos/server_proto_go"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
)

func main() {
	log.Println("Starting debug GoHome gRPC client...")
	secureChannelFlag := flag.Bool("secure_channel", false, "Use a secure gRPC channel.  Defaults to insecure.")
	serverHostFlag := flag.String("server_host", "localhost", "host:port of gRPC server")
	serverPortFlag := flag.String("server_port", "50051", "host:port of gRPC server")
	flag.Parse()

	ctx := context.Background()
	serverAddress := *serverHostFlag + ":" + *serverPortFlag
	var opts []grpc.DialOption

	if *secureChannelFlag {
		config := &tls.Config{
			InsecureSkipVerify: true,
		}
		opts = append(opts, grpc.WithTransportCredentials(credentials.NewTLS(config)))
	} else {
		opts = append(opts, grpc.WithInsecure())
	}

	conn, err := grpc.Dial(serverAddress, opts...)
	if err != nil {
		log.Fatalf("Unable to connect to gRPC server at %v", err)
	}
	defer conn.Close()

	c := server_proto.NewGoHomeClient(conn)

	// Test Set
	link := &link_proto.Link{
		Name:      "trololo",
		TargetUrl: `https://www.youtube.com/watch?v=sTSA_sWGM44`,
		Views:     500000000,
	}
	test2, err := c.Set(ctx, link)
	if err != nil {
		log.Fatalf("Get failed:", err)
	}
	log.Println(reflect.TypeOf(test2))
	log.Println(test2)

	// Test Get
	linkRequest := &server_proto.LinkRequest{
		Name: "trololo",
	}
	test, err := c.Get(ctx, linkRequest)
	if err != nil {
		log.Fatalf("Get failed:", err)
	}
	log.Println(reflect.TypeOf(test))
	log.Println(test)
}
