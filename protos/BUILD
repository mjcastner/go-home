load("@rules_proto//proto:defs.bzl", "proto_library")
load("@io_bazel_rules_go//proto:def.bzl", "go_proto_library")

# gazelle:proto disable
proto_library(
    name = "link_proto",
    srcs = ["link.proto"],
)

proto_library(
    name = "server_proto",
    srcs = ["server.proto"],
    deps = [":link_proto"],
)

go_proto_library(
    name = "link_proto_go",
    importpath = "github.com/mjcastner/go-home/protos/link_proto_go",
    protos = [":link_proto"],
    visibility = ["//visibility:public"],
)

go_proto_library(
    name = "server_proto_go",
    compilers = ["@io_bazel_rules_go//proto:go_grpc"],
    importpath = "github.com/mjcastner/go-home/protos/server_proto_go",
    protos = [":server_proto"],
    visibility = ["//visibility:public"],
    deps = [
        ":link_proto_go",
    ],
)
