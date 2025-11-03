import 'package:cnc_prac/features/task_screen/data/task_model.dart';

class TaskState {
  final List<TaskModel> tasks;
  final int selectedIndex;
  TaskState({required this.tasks, this.selectedIndex = -1});
  TaskState copyWith({List<TaskModel>? tasks, int? selectedIndex}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
