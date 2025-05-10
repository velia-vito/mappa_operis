part of '../settings.dart';

/// A setting field that accepts a value from a continuous range.
class ContinuousSetting<T> implements SettingInterface<T> {
  @override
  late final String name;

  @override
  late final void Function(T value) onChangeDoThis;

  late String _description;

  late T _value;

  late final bool Function(T value) _isValid;

  @override
  String get description => _description;

  @override
  T get value => _value;

  @override
  Iterable<T> get valueSet => [];

  @override
  bool get isContinuous => true;

  @override
  bool get isDiscrete => false;

  /// Create a setting field that accepts a value from a continuous range.
  ContinuousSetting({
    required this.name,
    String description = '',
    required T value,
    required bool Function(T value) isValid,
    required this.onChangeDoThis,
  }) {
    _value = value;
    _isValid = isValid;
    _description = description;
  }

  @override
  bool isValid(T value) => _isValid(value);

  @override
  void updateSetting(value) {}
}
