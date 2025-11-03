import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final bool loading;
  final String? error;
  final User? user;
  final bool obsecure;
  final bool conPassObsecure;
  AuthState({
    this.loading = false,
    this.error,
    this.user,
    this.obsecure = true,
    this.conPassObsecure = true,
  });

  AuthState copyWith({
    String? error,
    bool? loading,
    User? user,
    bool? obsecure,
    bool? conPassObsecure,
  }) {
    return AuthState(
      error: error ?? this.error,
      loading: loading ?? this.loading,
      user: user ?? this.user,
      obsecure: obsecure ?? this.obsecure,
      conPassObsecure: conPassObsecure ?? this.conPassObsecure,
    );
  }
}
