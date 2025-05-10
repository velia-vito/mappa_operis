part of '../settings.dart';

/// A setting field that only takes discrete values.
class DiscreteSetting<T> implements SettingInterface<T> {
  @override
  late final String name;

  @override
  late final Iterable<T> valueSet;

  @override
  late final void Function(T value) onChangeDoThis;

  late String _description;

  late T _value;

  @override
  String get description => _description;

  @override
  T get value => _value;

  @override
  bool get isContinuous => false;

  @override
  bool get isDiscrete => true;

  /// Creates a new setting field that only takes discrete values.
  DiscreteSetting({
    required this.name,
    String description = '',
    required T value,
    required this.valueSet,
    required this.onChangeDoThis,
  }) {
    _value = value;
  }

  @override
  bool isValid(T value) {
    return valueSet.contains(value);
  }

  @override
  void updateSetting(T value) {
    if (isValid(value)) {
      _value = value;
      onChangeDoThis(value);
    } else {
      throw StateError(
        'Provided value ($value) is not valid for this setting (acceptable values: $valueSet)',
      );
    }
  }
}
