import 'package:cnc_prac/features/task_screen/bloc/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInit());

  Future<void> checkUserCon() async {
    emit(LocationLoading());
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(LocationError(error: "Location permission denied"));
        return;
      }

      final possion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final cords = await placemarkFromCoordinates(
        possion.latitude,
        possion.longitude,
      );
      print("Here");

      final countryCode = cords.first.isoCountryCode;
      if (countryCode == "IN") {
        print("Here india");
        emit(LocationIndia());
      } else {
        emit(LocationOther());
      }
    } catch (e) {
      emit(LocationError(error: e.toString()));
    }
  }
}
