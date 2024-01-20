import 'package:flutter/material.dart';
import 'package:tutoring_app_2/app/core/extensions/build_context_ext.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.textEditingController,
    required this.myFocusNode,
    required this.myTextInputAction,
    required this.labelText,
    required this.prefexIcon,
    this.suffexIcon,
    this.togglePassword,
    required this.obsecureText,
    required this.onChanged,
    this.validator,
  });

  final TextEditingController textEditingController;
  final FocusNode myFocusNode;
  final TextInputAction myTextInputAction;
  final String labelText;
  final Icon prefexIcon;
  final Icon? suffexIcon;
  final Function()? togglePassword;
  final bool obsecureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.07,
      child: TextFormField(
        controller: textEditingController,
        focusNode: myFocusNode,
        textInputAction: myTextInputAction,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.all(20),
          label: Text(labelText),
          prefixIcon: prefexIcon,
          suffix: IconButton(
            icon: suffexIcon ?? const SizedBox(),
            onPressed: togglePassword,
          ),
        ),
        obscureText: obsecureText,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
