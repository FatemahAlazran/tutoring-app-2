import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutoring_app_2/app/config/router/my_named_route.dart';
import 'package:tutoring_app_2/app/config/theme/my_colors.dart';
import 'package:tutoring_app_2/app/core/extensions/build_context_ext.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WidgetRef ref, child) {
      final authProvider = ref.read(authControllerProvider.notifier);
      return Scaffold(
          appBar: AppBar(
              title: Row(children: [
        Text(context.translate.profile),
        IconButton(
            onPressed: () {
              authProvider.signOut().then((value) {
                if (value == true) {
                  context.goNamed(MyNamedRoutes.register);
                }
              });
            },
            icon: Icon(Icons.logout, color: MyColors.black))
      ])));
    });
  }
}
