# go-home
A loving and half-assed recreation of Google's go link server

## Setup (MacOS)
```
brew install bazel protobuf;
git clone git@github.com:mjcastner/go-home.git;
```

## Start gRPC server locally
```
bazel run //grpc/server:main;
```

## (Optional) Test debug gRPC client
```
bazel run //grpc/clients/debug:main;
```

## Build server Docker container
```
bazel run --platforms=@io_bazel_rules_go//go/toolchain:linux_amd64 //grpc/server:image_push;
```

## Deploy new server version
```
gcloud run deploy gohome-server \
--image="gcr.io/gohome-315922/gohome_server:latest" \
--allow-unauthenticated \
--platform managed \
--project=gohome-315922
```

## Build and deploy the gRPC ESPv2 Endpoint
**(One-time setup):** Reserve endpoint hostname

```
gcloud run deploy gohome-envoy-proxy \
--image="gcr.io/cloudrun/hello" \
--allow-unauthenticated \
--platform managed
```

## Generate protobuf API descriptor

```
python3 -m grpc_tools.protoc \
--include_imports \
--include_source_info \
--proto_path=. \
--descriptor_set_out=protos/server_descriptor.pb \
protos/server.proto
```

## Deploy endpoint configuration

```
gcloud endpoints services deploy protos/server_descriptor.pb espv2/gohome_endpoint.yaml
```


## Build ESPv2 container image

```
./espv2/build_image.sh \
-s gohome-envoy-proxy-b5p44absla-uw.a.run.app \
-c 2021-06-07r0 \
-p gohome-315922
```

## Deploy ESPv2 container image

```
gcloud run deploy gohome-envoy-proxy \
--image="gcr.io/gohome-315922/endpoints-runtime-serverless:2.27.0-gohome-envoy-proxy-b5p44absla-uw.a.run.app-2021-06-07r0" \
--allow-unauthenticated \
--platform managed \
--project=gohome-315922
```

## Give ESP ability to stop and start instances

```
gcloud run services add-iam-policy-binding gohome-envoy-proxy \
--member "serviceAccount:921769420023-compute@developer.gserviceaccount.com" \
--role "roles/run.invoker" \
--platform managed
```

## Run Flutter frontend
Optional: Regenerate protobufs
```
protoc --dart_out=grpc:frontend/lib/ protos/*.proto;
```

```
cd go-home/frontend;
flutter run -d chrome;
```