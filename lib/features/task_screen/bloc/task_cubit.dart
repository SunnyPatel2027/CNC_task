import 'package:cnc_prac/features/task_screen/bloc/task_state.dart';
import 'package:cnc_prac/features/task_screen/data/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit()
    : super(
        TaskState(
          tasks: [
            TaskModel(
              taskTitle: "Develop new login flow",
              taskDesc: "Iternal system",
              isUrgent: false,
              duration: Duration(hours: 1),
            ),
            TaskModel(
              taskTitle: "Submit Q3 Performance Review",
              taskDesc: "HR & Admin - Due today",
              isUrgent: true,
              duration: Duration(hours: 1, minutes: 30),
            ),
            TaskModel(
              taskTitle: "Review design mockups",
              taskDesc: "Project Phoenix",
              isUrgent: false,
              duration: Duration(hours: 1),
            ),
            TaskModel(
              taskTitle: "Prepare agenda for weekly sync",
              taskDesc: "Team Meeting",
              isUrgent: false,
              duration: Duration(hours: 1),
            ),
          ],
        ),
      );

  onTaptask({required int index}) {
    emit(state.copyWith(selectedIndex: index));
  }
}
