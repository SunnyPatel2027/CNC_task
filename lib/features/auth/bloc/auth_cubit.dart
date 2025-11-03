import 'package:cnc_prac/features/auth/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState()) {
    final user = _auth.currentUser;
    if (user != null) {
      emit(AuthState(user: user));
    }
  }
  final _auth = FirebaseAuth.instance;

  passObsecure() {
    emit(state.copyWith(obsecure: !state.obsecure));
  }

  conPassObsecure() {
    emit(state.copyWith(conPassObsecure: !state.conPassObsecure));
  }

  Future<void> login(String email, String password) async {
    emit(AuthState(loading: true));
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthState(user: cred.user));
    } catch (e) {
      emit(AuthState(error: e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthState(loading: true));
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthState(user: cred.user));
    } catch (e) {
      emit(AuthState(error: e.toString()));
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(AuthState());
  }
}
