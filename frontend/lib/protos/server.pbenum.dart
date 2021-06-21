///
//  Generated code. Do not modify.
//  source: protos/server.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class SetResponse_ResponseCode extends $pb.ProtobufEnum {
  static const SetResponse_ResponseCode SUCCESS = SetResponse_ResponseCode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUCCESS');
  static const SetResponse_ResponseCode FAILED = SetResponse_ResponseCode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILED');

  static const $core.List<SetResponse_ResponseCode> values = <SetResponse_ResponseCode> [
    SUCCESS,
    FAILED,
  ];

  static final $core.Map<$core.int, SetResponse_ResponseCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SetResponse_ResponseCode? valueOf($core.int value) => _byValue[value];

  const SetResponse_ResponseCode._($core.int v, $core.String n) : super(v, n);
}

