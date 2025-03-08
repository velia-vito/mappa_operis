part of '../units.dart';

/// A task that can be scheduled and tracked.
class Phase implements WorkUnit {
  late String _title;

  late String _description;

  late int _bufferInDays;

  final _predecessors = <WorkUnit>[];

  final _successors = <WorkUnit>[];

  final _tasks = <Task>[];

  @override
  int get id => throw UnimplementedError();

  // ===============================
  // === User Facing Description ===
  // ===============================.

  /// A non-unique identifier for the task.
  @override
  String get title => _title;

  /// Explanation/Details of the task.
  @override
  String get description => _description;

  // ===============================
  // === Work/Scheduling Details ===
  // ===============================.

  @override
  int get completedWorkInHours =>
      _tasks.fold<int>(0, (sum, task) => sum + task.completedWorkInHours);

  @override
  int get totalWorkInHours => _tasks.fold<int>(0, (sum, task) => sum + task.totalWorkInHours);

  @override
  int get remainingWorkInHours => totalWorkInHours - completedWorkInHours;

  @override
  int get completedDurationInDays => DateTime.now().difference(startDate).inDays;

  @override
  int get totalDurationInDays => firstTask.startDate.difference(lastTask.endDate).inDays;

  @override
  int get remainingDurationInDays => lastTask.endDate.difference(DateTime.now()).inDays;

  @override
  int get bufferInDays =>
      _bufferInDays != 0
          ? _bufferInDays
          : earliestStartDateAmongSuccessors.difference(latestEndDateAmongPredecessors).inDays -
              totalDurationInDays;

  @override
  DateTime get startDate => firstTask.startDate;

  @override
  DateTime get endDate => lastTask.endDate;

  // ===============================
  // =========== Utility ===========
  // ===============================.

  /// Latest end date among predecessors. [startDate] if no predecessors.
  DateTime get latestEndDateAmongPredecessors =>
      predecessors.isEmpty
          ? startDate
          : predecessors
              .reduce((taskA, taskB) => taskA.endDate.isAfter(taskB.endDate) ? taskA : taskB)
              .endDate;

  /// Earliest start date among successors. [endDate] if no successors.
  DateTime get earliestStartDateAmongSuccessors =>
      successors.isEmpty
          ? endDate
          : successors
              .reduce((taskA, taskB) => taskA.startDate.isBefore(taskB.startDate) ? taskA : taskB)
              .startDate;

  // ===============================
  // === InterTask Relationships ===
  // ===============================.

  @override
  List<WorkUnit> get predecessors => _predecessors;

  @override
  List<WorkUnit> get successors => _successors;

  /// The task that ends last.
  Task get lastTask =>
      _tasks.reduce((taskA, taskB) => taskA.endDate.isAfter(taskB.endDate) ? taskA : taskB);

  /// The task that starts first.
  Task get firstTask =>
      _tasks.reduce((taskA, taskB) => taskA.startDate.isBefore(taskB.startDate) ? taskA : taskB);

  /// First incomplete Task.
  Task? get firstIncompleteTask {
    for (var task in _tasks) {
      if (!task.isCompleted) {
        return task;
      }
    }

    return null;
  }

  /// Task that should be work on today.
  List<Task>? get todaysTasks =>
      _tasks.where((task) => task.startDate.isBefore(DateTime.now()) && !task.isCompleted).toList();

  // ===============================
  // ==== Flags, Internal Logic ====
  // ===============================.

  @override
  bool get canStart => predecessors.every((task) => task.isCompleted);

  @override
  bool get isOngoing => canStart && !isCompleted;

  @override
  bool get isCompleted => completedWorkInHours >= totalWorkInHours;

  @override
  bool get isOverdue => DateTime.now().isAfter(endDate) && !isCompleted;

  @override
  bool get isDelayed => DateTime.now().isAfter(startDate) && !canStart;

  @override
  /// Whether the task is critical (any delay to task will delay the project).
  ///
  /// ### Note
  /// 1. Tasks that have no predecessors or successors are not considered critical.
  bool get isCritical => bufferInDays <= 0;

  /// Create a new task that starts today (local time-zone).
  Phase.create({required String title, String description = '', required Task subTask}) {
    _title = title;
    _description = description;
    _tasks.add(subTask);
  }

  /// Add a sub-task to the phase.
  void addSubTask(Task task) {
    _tasks
      ..add(task)
      ..sort((taskA, taskB) => taskA.startDate.compareTo(taskB.startDate));
  }

  @override
  void addCompletedWorkHours(int additionalWorkHours) {
    throw UnsupportedError('Completed work hours of a Phase are derived from its sub-tasks.');
  }

  @override
  void addPredecessor(WorkUnit task) {
    if (task is! Task) {
      throw ArgumentError(
        'Task predecessors must be tasks: tried to add WorkUnit of type `${task.runtimeType}`.',
      );
    }

    _predecessors.add(task);
  }

  @override
  void addSuccessor(WorkUnit task) {
    if (task is! Task) {
      throw ArgumentError(
        'Task successors must be tasks: tried to add WorkUnit of type `${task.runtimeType}`.',
      );
    }

    _successors.add(task);
  }

  @override
  void removePredecessor(WorkUnit task) {
    // ignore: avoid-collection-methods-with-unrelated-types, as non-tasks are just ignored by `list.remove`.
    var _ = _predecessors.remove(task);
  }

  @override
  void removeSuccessor(WorkUnit task) {
    // ignore: avoid-collection-methods-with-unrelated-types, as non-tasks are just ignored by `list.remove`.
    var _ = _successors.remove(task);
  }

  @override
  void setBufferDaysTo(int newBufferDays) {
    _bufferInDays = newBufferDays;
  }

  @override
  void setDescriptionTo(String newDescription) {
    _description = newDescription;
  }

  @override
  void setStartDateTo(DateTime newStartDate) {
    throw UnsupportedError('Start date of a Phase is derived from its sub-tasks.');
  }

  @override
  void setTitleTo(String newTitle) {
    _title = newTitle;
  }

  @override
  void setTotalDurationInDaysTo(int newTotalDurationDays) {
    throw UnsupportedError('Duration of a Phase is derived from its sub-tasks.');
  }

  @override
  void setTotalWorkHoursTo(int newTotalWorkHours) {
    throw UnsupportedError('Total work hours of a Phase is derived from its sub-tasks.');
  }
}
