import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/providers/controller/auth_controller.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/providers/controller/form_provider.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/providers/state/auth_state.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/repo/auth_repo.dart';

final authFormController =
    ChangeNotifierProvider((ref) => MyAuthFormController());

final authRepositoryProvider = Provider<AuthRepo>((ref) {
  return AuthRepo(FirebaseAuth.instance);
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(AuthState(), AuthRepo(FirebaseAuth.instance));
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authRepository = AuthRepo(FirebaseAuth.instance);
  ref.read(authControllerProvider);
  return authRepository.authStateChanged;
});

final checkIfAuthinticatedFutureProvider =
    FutureProvider((ref) => ref.watch(authStateProvider));
