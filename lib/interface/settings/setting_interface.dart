part of '../../interfaces.dart';

/// Minimum requirement of any setting implementation.
abstract interface class SettingInterface<T> {
  /// Name of this setting.
  String get name;

  /// Description of this setting.
  String get description;

  /// Current value of this setting.
  T get value;

  /// Are the accepted values of this setting limited to a discrete set?
  bool get isDiscrete;

  /// Are the accepted values of this setting limited to a continuous range?
  bool get isContinuous;

  /// All possible values of this setting if it [isDiscrete]. Empty if [isContinuous].
  Iterable<T> get valueSet;

  /// Callback to be triggered when the value of this setting changes.
  void Function(T value) get onChangeDoThis;

  /// Test if a value is valid for this setting.
  bool isValid(T value);

  /// Update the value of this setting.
  void updateSetting(T value);
}
