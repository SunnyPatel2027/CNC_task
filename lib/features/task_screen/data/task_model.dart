class TaskModel {
  final String taskTitle;
  final String taskDesc;
  final bool isUrgent;
  final Duration duration;

  TaskModel({
    required this.taskTitle,
    required this.taskDesc,
    required this.isUrgent,
    required this.duration,
  });
}
