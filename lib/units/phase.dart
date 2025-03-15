part of 'units.dart';

/// A task that can be scheduled and tracked.
@TrackClass()
class Phase implements PhaseInterface {
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
  int get totalWorkInHours =>
      _tasks.fold<int>(0, (sum, task) => sum + task.totalWorkInHours);

  @override
  int get remainingWorkInHours => totalWorkInHours - completedWorkInHours;

  @override
  int get completedDurationInDays =>
      DateTime.now().difference(startDate).inDays;

  @override
  int get totalDurationInDays =>
      firstTask.startDate.difference(lastTask.endDate).inDays;

  @override
  int get remainingDurationInDays =>
      lastTask.endDate.difference(DateTime.now()).inDays;

  @override
  int get inherentBufferInDays =>
      earliestStartDateAmongSuccessors
          .difference(latestEndDateAmongPredecessors)
          .inDays -
      totalDurationInDays;

  @override
  int get assignedBufferInDays => _bufferInDays;

  @override
  int get totalBufferInDays => inherentBufferInDays + assignedBufferInDays;

  @override
  DateTime get startDate => firstTask.startDate;

  @override
  DateTime get endDate =>
      lastTask.endDate.add(Duration(days: assignedBufferInDays));

  // ===============================
  // =========== Utility ===========
  // ===============================.

  @override
  DateTime get latestEndDateAmongPredecessors =>
      predecessors.isEmpty
          ? startDate
          : predecessors
              .reduce(
                (taskA, taskB) =>
                    taskA.endDate.isAfter(taskB.endDate) ? taskA : taskB,
              )
              .endDate;

  @override
  DateTime get earliestStartDateAmongSuccessors =>
      successors.isEmpty
          ? endDate
          : successors
              .reduce(
                (taskA, taskB) =>
                    taskA.startDate.isBefore(taskB.startDate) ? taskA : taskB,
              )
              .startDate;

  // ===============================
  // === InterTask Relationships ===
  // ===============================.

  @override
  List<WorkUnit> get predecessors => _predecessors;

  @override
  List<WorkUnit> get successors => _successors;

  /// The task that starts first.
  @override
  Task get firstTask => _tasks.reduce(
    (taskA, taskB) => taskA.startDate.isBefore(taskB.startDate) ? taskA : taskB,
  );

  /// The task that ends last.
  @override
  Task get lastTask => _tasks.reduce(
    (taskA, taskB) => taskA.endDate.isAfter(taskB.endDate) ? taskA : taskB,
  );

  @override
  List<Task> get incompleteTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  @override
  List<Task> get delayedTasks =>
      _tasks.where((task) => task.isDelayed).toList();

  @override
  List<Task> get overdueTasks =>
      _tasks.where((task) => task.isOverdue).toList();

  /// Task that should be work on today.
  @override
  List<Task> get todaysTasks =>
      _tasks
          .where(
            (task) =>
                task.startDate.isBefore(DateTime.now()) && !task.isCompleted,
          )
          .toList();

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
  bool get isCritical => inherentBufferInDays <= 0;

  /// Create a new task that starts today (local time-zone).
  Phase.create({
    required String title,
    String description = '',
    required Task subTask,
  }) {
    _title = title;
    _description = description;
    _tasks.add(subTask);
  }

  /// Add a sub-task to the phase.
  @override
  void addSubTask(TaskInterface task) {
    _tasks
      ..add(task as Task)
      ..sort((taskA, taskB) => taskA.startDate.compareTo(taskB.startDate));
  }

  @override
  void setTitleTo(String newTitle) {
    _title = newTitle;
  }

  @override
  void setDescriptionTo(String newDescription) {
    _description = newDescription;
  }

  @override
  void setAssignedBufferInDaysTo(int newBufferInDays) {
    _bufferInDays = newBufferInDays;
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
}
