import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutoring_app_2/app/config/router/my_named_route.dart';
import 'package:tutoring_app_2/app/config/theme/my_colors.dart';
import 'package:tutoring_app_2/app/core/extensions/build_context_ext.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/providers/auth_provider.dart';
import 'package:tutoring_app_2/app/modules/chats/domain/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = _auth.currentUser!;
    setState(() {});
  }

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
        ])),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: context.screenHeight * .02,
              ),
            ),
            Text(
              "UserName:\n${user?.displayName}",
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                color: MyColors.secondary_500,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: context.screenHeight * 0.05,
            ),
            Text(
              "E-mail:\n${user?.email}",
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                  color: MyColors.secondary_500, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      );
    });
  }
}
