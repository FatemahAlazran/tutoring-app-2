import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/providers/state/auth_state.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/repo/auth_repo.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(super.state, this._authRepo);

  final AuthRepo _authRepo;

  Future<bool> register(
      {required String email,
      required String username,
      required String password}) async {
    state = state.copyWith(isLoading: true);

    try {
      User? user = await _authRepo.createUserWithEmailAndPassword(
          email: email.toString(),
          password: password.toString(),
          userName: username.toString());

      if (user != null) {
        await user.updateDisplayName(username.toString());
        await _authRepo.saveUserInfoToFirebase(
            user.uid, username.toString(), email.toString());
        state = state.copyWith(isLoading: false, isAuth: true);
        return true;
      }
    } catch (e) {
      state =
          state.copyWith(isLoading: false, isAuth: false, error: e.toString());
      return false;
    }
    return false;
  }

  Future<bool> googleSign() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authRepo.signInWithGoogle();
      if (user != null) {
        state = state.copyWith(isLoading: false, isAuth: true);
        return true;
      }
      state = state.copyWith(isLoading: false);
      return false;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message.toString());
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      await _authRepo.signOut();
      state = state.copyWith(
        isAuth: false,
        error: null,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
