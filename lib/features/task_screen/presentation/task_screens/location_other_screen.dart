import 'package:cnc_prac/features/task_screen/bloc/location_cubit.dart';
import 'package:cnc_prac/features/task_screen/bloc/task_cubit.dart';
import 'package:cnc_prac/features/task_screen/bloc/task_state.dart';
import 'package:cnc_prac/features/task_screen/presentation/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationOtherScreen extends StatelessWidget {
  const LocationOtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.location_off_outlined, color: Colors.orange),
        ),
        SizedBox(height: 20),
        Text(
          "Location Not Verified",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "No avaiable task for this location. Please be inside a verified location to see tasks and clock-in.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black45,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20),
        IntrinsicWidth(
          child: InkWell(
            onTap: () {
              context.read<LocationCubit>().checkUserCon();
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Refresh Location",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
