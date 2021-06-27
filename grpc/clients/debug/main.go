package main

import (
	"context"
	"crypto/tls"
	"flag"
	"log"

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

	// Assemble example links
	names := []string{"trololo", "blackspine", "bananaphone"}
	urls := []string{"https://www.youtube.com/watch?v=sTSA_sWGM44", "https://www.youtube.com/watch?v=_igaLv7ro8o", "https://www.youtube.com/watch?v=UqWwsUhrFBw"}
	views := []int64{500, 250, 1}
	links := make([]link_proto.Link, 3)
	for i := range links {
		links[i].Name = names[i]
		links[i].TargetUrl = urls[i]
		links[i].Views = views[i]
	}

	// Set
	for i := range links {
		_, err := c.Set(ctx, &links[i])
		if err != nil {
			log.Fatalf("Set failed:", err)
		} else {
			log.Printf("Successfully set key '%s' with value '%s'", links[i].Name, links[i].TargetUrl)
		}
	}

	// Batch set

	// Get
	for i := range names {
		linkRequest := &server_proto.LinkRequest{
			Name: names[i],
		}
		link, err := c.Get(ctx, linkRequest)
		if err != nil {
			log.Fatalf("Get failed:", err)
		} else {
			log.Printf("Successfully retrieved key '%s' with value '%s'", link.Name, link.TargetUrl)
		}
	}

	// Batch get
	batchGetRequest := &server_proto.LinkRequestBatch{}
	for i := range names {
		batchGetRequest.Names = append(batchGetRequest.Names, names[i])
	}
	batch, err := c.BatchGet(ctx, batchGetRequest)
	if err != nil {
		log.Fatalf("Batch get failed:", err)
	} else {
		log.Println("Successfully retrieved link batch!")
	}
	log.Println(batch)
}
