/// The fundamental details any implementation of a task should have.
abstract interface class Task {
  /// A unique identifier for the task.
  int get id;

  // ===============================
  // === User Facing Description ===
  // ===============================.

  /// A non-unique identifier for the task.
  String get title;

  /// Explanation/Details of the task.
  String get description;

  // ===============================
  // === Work/Scheduling Details ===
  // ===============================.

  /// The amount of work that has been completed.
  int get completedWorkInHours;

  /// Working Hours.
  int get totalWorkInHours;

  /// The amount of work that has not been completed.
  int get remainingWorkInHours;

  /// The number of scheduled working days completed.
  int get completedDurationInDays;

  /// Working Days.
  int get totalDurationInDays;

  /// The number of scheduled working days remaining.
  int get remainingDurationInDays;

  /// The number of days that the task can be delayed without delaying the project.
  int get bufferInDays;

  /// The number of hours that the task can be delayed without delaying the project.
  int get bufferInHours;

  /// The date the task is expected to start to be completed on time.
  DateTime get startDate;

  /// The date the task is expected to end to be completed on time.
  DateTime get endDate;

  // ===============================
  // === InterTask Relationships ===
  // ===============================.

  /// Tasks that have to be completed before this task can start.
  List<Task> get predecessors;

  /// Tasks that can only start after this task is completed.
  List<Task> get successors;

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
}
