part of '../json.dart';

/// Metadata annotation to create serialization/deserialization code.
class PickleClass {
  final bool allFields;

  final Type type;

  /// Default const constructor.
  const PickleClass({required this.type, this.allFields = false});
}
