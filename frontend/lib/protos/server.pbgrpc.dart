///
//  Generated code. Do not modify.
//  source: protos/server.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'server.pb.dart' as $0;
import 'link.pb.dart' as $1;
export 'server.pb.dart';

class GoHomeClient extends $grpc.Client {
  static final _$get = $grpc.ClientMethod<$0.LinkRequest, $1.Link>(
      '/server.GoHome/Get',
      ($0.LinkRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Link.fromBuffer(value));
  static final _$set = $grpc.ClientMethod<$1.Link, $0.SetResponse>(
      '/server.GoHome/Set',
      ($1.Link value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SetResponse.fromBuffer(value));

  GoHomeClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Link> get($0.LinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$0.SetResponse> set($1.Link request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$set, request, options: options);
  }
}

abstract class GoHomeServiceBase extends $grpc.Service {
  $core.String get $name => 'server.GoHome';

  GoHomeServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.LinkRequest, $1.Link>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LinkRequest.fromBuffer(value),
        ($1.Link value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Link, $0.SetResponse>(
        'Set',
        set_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Link.fromBuffer(value),
        ($0.SetResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.Link> get_Pre(
      $grpc.ServiceCall call, $async.Future<$0.LinkRequest> request) async {
    return get(call, await request);
  }

  $async.Future<$0.SetResponse> set_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Link> request) async {
    return set(call, await request);
  }

  $async.Future<$1.Link> get($grpc.ServiceCall call, $0.LinkRequest request);
  $async.Future<$0.SetResponse> set($grpc.ServiceCall call, $1.Link request);
}
