FROM envoyproxy/envoy-alpine:v1.17.0
EXPOSE 8080 8081 9901
COPY envoy.yaml /etc/envoy/envoy.yaml
RUN apk --no-cache add ca-certificates