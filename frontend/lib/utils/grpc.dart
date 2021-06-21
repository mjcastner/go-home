import 'package:grpc/grpc_web.dart';
import 'package:go_home/protos/server.pbgrpc.dart';

// final String endpoint = 'localhost:50051';

GoHomeClient initGoHomeClient() {
  final channel = GrpcWebClientChannel.xhr(
      Uri.parse('https://gohome-envoy-proxy-b5p44absla-uw.a.run.app')
      );
  final goHomeStub = GoHomeClient(
    channel,
    options: CallOptions(
      timeout: Duration(seconds: 30),
    ),
  );
  return goHomeStub;
}
