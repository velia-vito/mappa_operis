part of '../json.dart';

/// Metadata annotation to create serialization/deserialization code.
class PickleClass {
  final bool allFields;

  /// Default const constructor.
  const PickleClass({this.allFields = false});
}
