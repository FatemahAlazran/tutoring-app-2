import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutoring_app_2/app/config/router/my_named_route.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/providers/auth_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIfUserAuthinticated =
        ref.watch(checkIfAuthinticatedFutureProvider);
    return Scaffold(
        body: Center(
      child: checkIfUserAuthinticated.when(data: (data) {
        if (data.value?.uid != null) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.goNamed(MyNamedRoutes.chats);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.goNamed(MyNamedRoutes.register);
          });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }, error: (Object error, StackTrace stackTrace) {
        return Center(child: Text(error.toString()));
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    ));
  }
}
