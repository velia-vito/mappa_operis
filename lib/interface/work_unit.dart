// ignore_for_file: member-ordering

part of '../interfaces.dart';

/// The fundamental details any implementation of a task should have.
abstract interface class WorkUnit {
  /// A unique identifier for the task.
  int get id;

  // ===============================
  // === User Facing Description ===
  // ===============================.

  /// A non-unique identifier for the task.
  String get title;

  /// Update the title of the task.
  void setTitleTo(String newTitle);

  /// Explanation/Details of the task.
  String get description;

  /// Update the description of the task.
  void setDescriptionTo(String newDescription);

  // ===============================
  // === Work/Scheduling Details ===
  // ===============================.

  /// The amount of work that has been completed.
  int get completedWorkInHours;

  /// Update the amount of work completed. (Add's to the current amount).
  void addCompletedWorkHours(int additionalWorkHours);

  /// Working Hours.
  int get totalWorkInHours;

  /// Update the total amount of work required.
  void setTotalWorkHoursTo(int newTotalWorkHours);

  /// The amount of work that has not been completed.
  int get remainingWorkInHours;

  /// The number of scheduled working days completed.
  int get completedDurationInDays;

  /// Working Days.
  int get totalDurationInDays;

  /// Update the total duration of the task.
  void setTotalDurationInDaysTo(int newTotalDurationDays);

  /// The number of scheduled working days remaining.
  int get remainingDurationInDays;

  /// The number of days that the task can be delayed without delaying the project.
  int get bufferInDays;

  /// Update the buffer days of the task.
  void setBufferDaysTo(int newBufferDays);

  /// The date the task is expected to start to be completed on time.
  DateTime get startDate;

  /// Update the start date of the task.
  void setStartDateTo(DateTime newStartDate);

  /// The date the task is expected to end to be completed on time.
  DateTime get endDate;

  // ===============================
  // === InterTask Relationships ===
  // ===============================.

  /// Tasks that have to be completed before this task can start.
  List<WorkUnit> get predecessors;

  /// Add predecessor to the task.
  void addPredecessor(WorkUnit task);

  /// Remove predecessor from the task.
  void removePredecessor(WorkUnit task);

  /// Tasks that can only start after this task is completed.
  List<WorkUnit> get successors;

  /// Add successor to the task.
  void addSuccessor(WorkUnit task);

  /// Remove successor from the task.
  void removeSuccessor(WorkUnit task);

  // ===============================
  // ==== Flags, Internal Logic ====
  // ===============================.

  /// Whether the task can start.
  bool get canStart;

  /// Whether the task is ongoing.
  bool get isOngoing;

  /// Whether the task is completed.
  bool get isCompleted;

  /// Whether the task is overdue (ongoing past completion date).
  bool get isOverdue;

  /// Whether the task is delayed (un-started past start date).
  bool get isDelayed;

  /// Whether the task is critical (any delay to task will delay the project).
  bool get isCritical;

  // ===============================
  // =========== Utility ===========
  // ===============================.
}
