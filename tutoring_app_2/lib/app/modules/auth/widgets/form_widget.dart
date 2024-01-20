import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutoring_app_2/app/core/extensions/build_context_ext.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/helper/auth_validators.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/providers/auth_provider.dart';
import 'package:tutoring_app_2/app/modules/auth/widgets/textform_widget.dart';

class MyFormFields extends ConsumerStatefulWidget {
  const MyFormFields({super.key, required this.formKey});

  final GlobalKey<FormState>? formKey;

  @override
  ConsumerState<MyFormFields> createState() => _MyFormFieldsState();
}

class _MyFormFieldsState extends ConsumerState<MyFormFields> {
  final _authValidators = AuthValidators();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode userNameNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    userNameNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = ref.watch(authFormController);
    return SizedBox(
      child: Form(
        key: widget.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFormField(
                textEditingController: emailController,
                myFocusNode: emailNode,
                myTextInputAction: TextInputAction.next,
                labelText: context.translate.email,
                prefexIcon: const Icon(Icons.email),
                obsecureText: false,
                onChanged: (val) {
                  formProvider.setEmailField(val);
                },
                validator: (value) {
                  return _authValidators.emailValidator(value);
                },
              ),
              SizedBox(
                height: context.screenHeight * 0.03,
              ),
              CustomTextFormField(
                textEditingController: userNameController,
                obsecureText: false,
                myFocusNode: userNameNode,
                validator: (input) => _authValidators.userNameValidator(input),
                prefexIcon: const Icon(Icons.person),
                labelText: context.translate.userName,
                myTextInputAction: TextInputAction.next,
                onChanged: (value) {
                  formProvider.setUserNameField(value);
                },
              ),
              SizedBox(
                height: context.screenHeight * 0.03,
              ),
              CustomTextFormField(
                textEditingController: passwordController,
                obsecureText:
                    formProvider.togglePassword == false ? true : false,
                myFocusNode: passwordNode,
                validator: (input) => _authValidators.passwordVlidator(input),
                prefexIcon: const Icon(Icons.password),
                labelText: context.translate.password,
                myTextInputAction: TextInputAction.next,
                onChanged: (value) {
                  formProvider.setPasswordField(value);
                },
                togglePassword: () {
                  formProvider.togglePasswordIcon();
                },
                suffexIcon: Icon(
                  formProvider.togglePassword
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye_rounded,
                ),
              ),
              SizedBox(
                height: context.screenHeight * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
