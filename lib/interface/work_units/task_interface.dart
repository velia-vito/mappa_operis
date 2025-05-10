part of '../../interfaces.dart';

/// A task that can be scheduled and tracked.
abstract interface class TaskInterface extends WorkUnit {
  /// Update the amount of work completed. (Add's to the current amount).
  void addCompletedWorkHours(int additionalWorkHours);

  /// Update the total amount of work required.
  void setTotalWorkHoursTo(int newTotalWorkHours);

  /// Update the total duration of the task.
  void setTotalDurationInDaysTo(int newTotalDurationDays);

  /// Update the buffer days of the task.
  void setAssignedBufferInDaysTo(int newBufferDays);

  /// Update the start date of the task.
  void setStartDateTo(DateTime newStartDate);
}
