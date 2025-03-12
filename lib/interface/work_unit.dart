// ignore_for_file: member-ordering

part of 'interfaces.dart';

/// The fundamental details any implementation any Piece of Work should have.
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

  /// The number of days that the task can be delayed without delaying the project by virtue of its
  /// dependencies and dependents.
  int get inherentBufferInDays;

  /// The number of additional days assigned as a buffer period. (is considered part of the task
  /// duration, and is not considered while calculating [inherentBufferInDays] or [isCritical]).
  int get assignedBufferInDays;

  /// Total buffer time available.
  int get totalBufferInDays;

  /// Update the buffer days of the task.
  void setAssignedBufferInDaysTo(int newBufferDays);

  /// The date the task is expected to start to be completed on time.
  DateTime get startDate;

  /// The date the task is expected to end to be completed on time. (includes
  /// [assignedBufferInDays]).
  DateTime get endDate;

  // ===============================
  // =========== Utility ===========
  // ===============================.

  /// Latest end date among predecessors. [startDate] if no predecessors.
  DateTime get latestEndDateAmongPredecessors;

  /// Earliest start date among successors. [endDate] if no successors.
  DateTime get earliestStartDateAmongSuccessors;

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
}
