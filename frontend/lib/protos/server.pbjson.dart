///
//  Generated code. Do not modify.
//  source: protos/server.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use linkBatchDescriptor instead')
const LinkBatch$json = const {
  '1': 'LinkBatch',
  '2': const [
    const {'1': 'links', '3': 1, '4': 3, '5': 11, '6': '.Link', '10': 'links'},
  ],
};

/// Descriptor for `LinkBatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkBatchDescriptor = $convert.base64Decode('CglMaW5rQmF0Y2gSGwoFbGlua3MYASADKAsyBS5MaW5rUgVsaW5rcw==');
@$core.Deprecated('Use linkRequestDescriptor instead')
const LinkRequest$json = const {
  '1': 'LinkRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `LinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkRequestDescriptor = $convert.base64Decode('CgtMaW5rUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1l');
@$core.Deprecated('Use linkRequestBatchDescriptor instead')
const LinkRequestBatch$json = const {
  '1': 'LinkRequestBatch',
  '2': const [
    const {'1': 'names', '3': 1, '4': 3, '5': 9, '10': 'names'},
  ],
};

/// Descriptor for `LinkRequestBatch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkRequestBatchDescriptor = $convert.base64Decode('ChBMaW5rUmVxdWVzdEJhdGNoEhQKBW5hbWVzGAEgAygJUgVuYW1lcw==');
@$core.Deprecated('Use setResponseDescriptor instead')
const SetResponse$json = const {
  '1': 'SetResponse',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 14, '6': '.server.SetResponse.ResponseCode', '10': 'code'},
  ],
  '4': const [SetResponse_ResponseCode$json],
};

@$core.Deprecated('Use setResponseDescriptor instead')
const SetResponse_ResponseCode$json = const {
  '1': 'ResponseCode',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILED', '2': 1},
  ],
};

/// Descriptor for `SetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setResponseDescriptor = $convert.base64Decode('CgtTZXRSZXNwb25zZRI0CgRjb2RlGAEgASgOMiAuc2VydmVyLlNldFJlc3BvbnNlLlJlc3BvbnNlQ29kZVIEY29kZSInCgxSZXNwb25zZUNvZGUSCwoHU1VDQ0VTUxAAEgoKBkZBSUxFRBAB');
