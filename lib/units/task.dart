part of '../units.dart';

/// A task that can be scheduled and tracked.
class Task implements WorkUnit {
  late String _title;

  late String _description;

  late int _completedWorkInHours;

  late int _totalWorkInHours;

  late int _durationInDays;

  late int _bufferInDays;

  late DateTime _startDate;

  final _predecessors = <Task>[];

  final _successors = <Task>[];

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
  int get completedWorkInHours => _completedWorkInHours;

  @override
  int get totalWorkInHours => _totalWorkInHours;

  @override
  int get remainingWorkInHours => _totalWorkInHours - _completedWorkInHours;

  @override
  int get completedDurationInDays => DateTime.now().difference(_startDate).inDays;

  @override
  int get totalDurationInDays => _durationInDays;

  @override
  int get remainingDurationInDays => -endDate.difference(DateTime.now()).inDays;

  @override
  int get bufferInDays =>
      _bufferInDays != 0
          ? _bufferInDays
          : earliestStartDateAmongSuccessors.difference(latestEndDateAmongPredecessors).inDays -
              _durationInDays;

  @override
  DateTime get startDate => _startDate;

  @override
  DateTime get endDate => _startDate.add(Duration(days: _durationInDays + _bufferInDays));

  // ===============================
  // =========== Utility ===========
  // ===============================.

  /// Latest end date among predecessors. [startDate] if no predecessors.
  DateTime get latestEndDateAmongPredecessors =>
      _predecessors.isEmpty
          ? _startDate
          : _predecessors
              .reduce((taskA, taskB) => taskA.endDate.isAfter(taskB.endDate) ? taskA : taskB)
              .endDate;

  /// Earliest start date among successors. [endDate] if no successors.
  DateTime get earliestStartDateAmongSuccessors =>
      _successors.isEmpty
          ? endDate
          : _successors
              .reduce((taskA, taskB) => taskA.startDate.isBefore(taskB.startDate) ? taskA : taskB)
              .startDate;

  // ===============================
  // === InterTask Relationships ===
  // ===============================.

  @override
  List<Task> get predecessors => _predecessors;

  @override
  List<Task> get successors => _successors;

  // ===============================
  // ==== Flags, Internal Logic ====
  // ===============================.

  @override
  bool get canStart => _predecessors.every((task) => task.isCompleted);

  @override
  bool get isOngoing => canStart && !isCompleted;

  @override
  bool get isCompleted => _completedWorkInHours >= _totalWorkInHours;

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
  Task.create({
    required String title,
    String description = '',
    required int workInHours,
    int completedWorkInHours = 0,
    DateTime? startDate,
    required int durationInDays,
    int bufferInDays = 0,
  }) {
    _title = title;

    _description = description;

    _totalWorkInHours = workInHours;

    _completedWorkInHours = completedWorkInHours;

    _startDate = (startDate ?? DateTime.now()).copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    _durationInDays = durationInDays;

    _bufferInDays = bufferInDays;
  }

  /// Create a new task that requires the completion of the current task to start.
  Task createSuccessor(
    String title,
    int workInHours,
    int durationInDays, [
    int bufferInDays = 0,
    String description = '',
  ]) {
    var successor = Task.create(
      title: title,
      description: description,
      workInHours: workInHours,
      startDate: endDate,
      durationInDays: durationInDays,
      bufferInDays: bufferInDays,
    );

    _successors.add(successor);

    return successor;
  }

  @override
  void addCompletedWorkHours(int additionalWorkHours) {
    _completedWorkInHours += additionalWorkHours;
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
    _startDate = newStartDate;
  }

  @override
  void setTitleTo(String newTitle) {
    _title = newTitle;
  }

  @override
  void setTotalDurationInDaysTo(int newTotalDurationDays) {
    _durationInDays = newTotalDurationDays;
  }

  @override
  void setTotalWorkHoursTo(int newTotalWorkHours) {
    _totalWorkInHours = newTotalWorkHours;
  }
}
