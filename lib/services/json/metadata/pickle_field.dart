part of '../json.dart';

/// Represents a field in a pickle structure with metadata.
class PickleField {
  /// A function to reverse engineer the value.
  final Function reverseEngineerValue;

  /// Which Constructor field to use.
  final String field;

  /// Creates a [PickleField] with the given [field] and an optional [reverseEngineerValue] function.
  const PickleField({
    required this.field,
    this.reverseEngineerValue = _defaultReverseEngineerValue,
  });

  /// Default reverse engineer function that returns the value as is.
  static Object _defaultReverseEngineerValue(Object value) => value;
}