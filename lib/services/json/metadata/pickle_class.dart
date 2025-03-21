part of '../json.dart';

/// Metadata annotation to create serialization/deserialization code.
class PickleClass {
  /// Default const constructor.
  const PickleClass({this.constructor = 'new'});

  final String constructor;
}
