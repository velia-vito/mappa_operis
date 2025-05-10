part of '../../interfaces.dart';

/// A group of tasks that are related, i.e. Phases.
abstract interface class PhaseInterface extends WorkUnit {
  /// The task that starts first.
  TaskInterface get firstTask;

  /// The task that ends last.
  TaskInterface get lastTask;

  /// Tasks that are incomplete (past, present, and future).
  List<TaskInterface> get incompleteTasks;

  /// Tasks that are behind schedule (un-started beyond start date).
  List<TaskInterface> get delayedTasks;

  /// Tasks that are behind schedule (ongoing past due date).
  List<TaskInterface> get overdueTasks;

  /// Task that should be work on today.
  List<TaskInterface> get todaysTasks;

  /// Add a sub-task to the phase.
  void addSubTask(TaskInterface task);
}
