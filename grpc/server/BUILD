load("@io_bazel_rules_go//go:def.bzl", "go_binary")
load("@io_bazel_rules_docker//container:container.bzl", "container_push")
load("@io_bazel_rules_docker//go:image.bzl", "go_image")

# gazelle:exclude main.go
go_binary(
    name = "main",
    srcs = ["main.go"],
    visibility = ["//visibility:public"],
    deps = [
        "//protos:link_proto_go",
        "//protos:server_proto_go",
        "@com_github_jackc_pgx//stdlib:go_default_library",
        "@org_golang_google_grpc//:go_default_library",
        "@org_modernc_sqlite//:sqlite",
    ],
)

go_image(
    name = "image",
    embed = [":main"],
)

container_push(
    name = "image_push",
    format = "Docker",
    image = ":image",
    registry = "gcr.io",
    repository = "gohome-315922/gohome_server",
    tag = "latest",
)
