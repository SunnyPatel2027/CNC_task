abstract class LocationState {}

class LocationInit extends LocationState {}

class LocationLoading extends LocationState {}

class LocationIndia extends LocationState {}

class LocationOther extends LocationState {}

class LocationError extends LocationState {
  final String? error;
  LocationError({this.error});
}
