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
	names := []string{"facebook", "apple", "amazon", "netflix", "google"}
	urls := []string{
		"http://www.facebook.com",
		"http://www.apple.com",
		"http://www.amazon.com",
		"http://www.netflix.com",
		"http://www.google.com",
	}
	views := []int64{500, 400, 300, 200, 100}
	links := make([]link_proto.Link, 5)
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
	ms := &link_proto.Link{
		Name: "microsoft",
		TargetUrl: "http://www.microsoft.com",
		Views: 0,
	}
	links = append(links, *ms)
	linkBatch := &server_proto.LinkBatch{}

	for i := range links {
		linkBatch.Links = append(linkBatch.Links, &links[i])
	}
	log.Println(linkBatch)
	_, err = c.BatchSet(ctx, linkBatch)
	if err != nil {
		log.Fatalf("Set failed:", err)
	} else {
		log.Print("Successfully set batch of links")
	}

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

	// Delete
	deleteRequest := &server_proto.LinkRequest{
		Name: "microsoft",
	}
	_, err = c.Delete(ctx, deleteRequest)
	if err != nil {
		log.Println(err)
	} else {
		log.Printf("Successfully deleted link %s", deleteRequest.Name)
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
