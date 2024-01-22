import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutoring_app_2/app/config/router/my_named_route.dart';
import 'package:tutoring_app_2/app/config/theme/my_colors.dart';
import 'package:tutoring_app_2/app/core/extensions/build_context_ext.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/providers/auth_provider.dart';
import 'package:tutoring_app_2/app/modules/auth/widgets/form_widget.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);
    final formProvider = ref.watch(authFormController);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.primary_500,
        automaticallyImplyLeading: false,
        title: Text(
          context.translate.login,
          style: context.textTheme.headlineMedium?.copyWith(
            color: MyColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.screenHeight * 0.2,
              ),
              MyFormFields(
                formKey: formKey,
              ),
              SizedBox(
                height: context.screenHeight * 0.04,
              ),
              ElevatedButton(
                onPressed: () {
                  authController
                      .handleSignInEmail(
                          formProvider.email, formProvider.password)
                      .then((user) {
                    context.goNamed(MyNamedRoutes.chats);
                  }).catchError((e) => print(e));
                  // if (formKey.currentState?.validate() == true) {
                  //   authController
                  //       .login(
                  //           email: formProvider.email,
                  //           password: formProvider.password)
                  //       .then((value) {
                  //     if (value == true) {
                  //       context.goNamed(MyNamedRoutes.chats);
                  //     }
                  //   });
                  // }
                },
                child: Text(
                  context.translate.login,
                ),
              ),
              SizedBox(
                height: context.screenHeight * 0.04,
              ),
              Visibility(
                  visible: authState.isLoading == true,
                  child: Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
      ),
    );
  }
}
