part of 'interfaces.dart';

/// Projects Interface — Identical to [PhaseInterface] but with different return types.
abstract interface class ProjectInterface extends WorkUnit {
  /// The task that starts first.
  WorkUnit get firstTask;

  /// The task that ends last.
  WorkUnit get lastTask;

  /// Tasks that are incomplete (past, present, and future).
  List<WorkUnit> get incompleteTasks;

  /// Tasks that are behind schedule (un-started beyond start date).
  List<WorkUnit> get delayedTasks;

  /// Tasks that are behind schedule (ongoing past due date).
  List<WorkUnit> get overdueTasks;

  /// Task that should be work on today.
  List<WorkUnit> get todaysTasks;

  /// Add a sub-task to the phase.
  void addSubTask(WorkUnit task);
}
