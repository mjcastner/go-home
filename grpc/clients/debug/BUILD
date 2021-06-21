load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")

go_binary(
    name = "main",
    embed = [":debug_lib"],
    visibility = ["//visibility:public"],
)

go_library(
    name = "debug_lib",
    srcs = ["main.go"],
    importpath = "github.com/mjcastner/go-home/grpc/clients/debug",
    visibility = ["//visibility:private"],
    deps = [
        "//protos:link_proto_go",
        "//protos:server_proto_go",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_google_grpc//credentials",
    ],
)
