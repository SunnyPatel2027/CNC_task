import 'package:cnc_prac/features/active_task_screen/presentation/active_task_screen.dart';
import 'package:cnc_prac/features/auth/presentation/login_screen.dart';
import 'package:cnc_prac/features/task_screen/bloc/location_cubit.dart';
import 'package:cnc_prac/features/task_screen/bloc/location_state.dart';
import 'package:cnc_prac/features/task_screen/bloc/task_cubit.dart';
import 'package:cnc_prac/features/task_screen/bloc/task_state.dart';
import 'package:cnc_prac/features/task_screen/presentation/task_screens/location_india_screen.dart';
import 'package:cnc_prac/features/task_screen/presentation/task_screens/location_other_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationCubit()..checkUserCon()),
        BlocProvider(create: (context) => TaskCubit()),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(color: Colors.grey[400]),
          ),
          title: Text(
            "Tasks",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) => FloatingActionButton.extended(
            onPressed: () {
              if (state.selectedIndex >= 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActiveTaskScreen()),
                );
              }
            },
            label: Text(
              "Clock In",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: state.selectedIndex != -1
                ? Colors.blue
                : Colors.grey,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              if (state is LocationLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is LocationIndia) {
                return LocationIndiaScreen();
              } else if (state is LocationOther) {
                return LocationOtherScreen();
              } else if (state is LocationError) {
                return Center(child: Text("Error : ${state.error}"));
              } else {
                return SizedBox(child: Center(child: Text("India")));
              }
            },
          ),
        ),
      ),
    );
  }
}
