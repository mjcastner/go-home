import 'package:grpc/grpc_web.dart';
import 'package:go_home/protos/server.pbgrpc.dart';

const goHomeHost = String.fromEnvironment('GOHOME_HOST',
    defaultValue: 'http://localhost:8081');

GoHomeClient initGoHomeClient() {
  final channel = GrpcWebClientChannel.xhr(Uri.parse(goHomeHost));
  final goHomeStub = GoHomeClient(
    channel,
    options: CallOptions(
      timeout: Duration(seconds: 30),
    ),
  );
  return goHomeStub;
}
