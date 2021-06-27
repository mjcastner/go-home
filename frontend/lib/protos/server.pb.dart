///
//  Generated code. Do not modify.
//  source: protos/server.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'link.pb.dart' as $1;

import 'server.pbenum.dart';

export 'server.pbenum.dart';

class LinkBatch extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkBatch', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'server'), createEmptyInstance: create)
    ..pc<$1.Link>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'links', $pb.PbFieldType.PM, subBuilder: $1.Link.create)
    ..hasRequiredFields = false
  ;

  LinkBatch._() : super();
  factory LinkBatch({
    $core.Iterable<$1.Link>? links,
  }) {
    final _result = create();
    if (links != null) {
      _result.links.addAll(links);
    }
    return _result;
  }
  factory LinkBatch.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkBatch.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkBatch clone() => LinkBatch()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkBatch copyWith(void Function(LinkBatch) updates) => super.copyWith((message) => updates(message as LinkBatch)) as LinkBatch; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkBatch create() => LinkBatch._();
  LinkBatch createEmptyInstance() => create();
  static $pb.PbList<LinkBatch> createRepeated() => $pb.PbList<LinkBatch>();
  @$core.pragma('dart2js:noInline')
  static LinkBatch getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkBatch>(create);
  static LinkBatch? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$1.Link> get links => $_getList(0);
}

class LinkRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'server'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  LinkRequest._() : super();
  factory LinkRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory LinkRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkRequest clone() => LinkRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkRequest copyWith(void Function(LinkRequest) updates) => super.copyWith((message) => updates(message as LinkRequest)) as LinkRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkRequest create() => LinkRequest._();
  LinkRequest createEmptyInstance() => create();
  static $pb.PbList<LinkRequest> createRepeated() => $pb.PbList<LinkRequest>();
  @$core.pragma('dart2js:noInline')
  static LinkRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkRequest>(create);
  static LinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class LinkRequestBatch extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkRequestBatch', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'server'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'names')
    ..hasRequiredFields = false
  ;

  LinkRequestBatch._() : super();
  factory LinkRequestBatch({
    $core.Iterable<$core.String>? names,
  }) {
    final _result = create();
    if (names != null) {
      _result.names.addAll(names);
    }
    return _result;
  }
  factory LinkRequestBatch.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkRequestBatch.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkRequestBatch clone() => LinkRequestBatch()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkRequestBatch copyWith(void Function(LinkRequestBatch) updates) => super.copyWith((message) => updates(message as LinkRequestBatch)) as LinkRequestBatch; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkRequestBatch create() => LinkRequestBatch._();
  LinkRequestBatch createEmptyInstance() => create();
  static $pb.PbList<LinkRequestBatch> createRepeated() => $pb.PbList<LinkRequestBatch>();
  @$core.pragma('dart2js:noInline')
  static LinkRequestBatch getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkRequestBatch>(create);
  static LinkRequestBatch? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get names => $_getList(0);
}

class SetResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'server'), createEmptyInstance: create)
    ..e<SetResponse_ResponseCode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code', $pb.PbFieldType.OE, defaultOrMaker: SetResponse_ResponseCode.SUCCESS, valueOf: SetResponse_ResponseCode.valueOf, enumValues: SetResponse_ResponseCode.values)
    ..hasRequiredFields = false
  ;

  SetResponse._() : super();
  factory SetResponse({
    SetResponse_ResponseCode? code,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    return _result;
  }
  factory SetResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetResponse clone() => SetResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetResponse copyWith(void Function(SetResponse) updates) => super.copyWith((message) => updates(message as SetResponse)) as SetResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetResponse create() => SetResponse._();
  SetResponse createEmptyInstance() => create();
  static $pb.PbList<SetResponse> createRepeated() => $pb.PbList<SetResponse>();
  @$core.pragma('dart2js:noInline')
  static SetResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetResponse>(create);
  static SetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SetResponse_ResponseCode get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(SetResponse_ResponseCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);
}

