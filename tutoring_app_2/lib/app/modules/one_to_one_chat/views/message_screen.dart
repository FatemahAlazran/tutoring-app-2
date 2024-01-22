import 'package:flutter/material.dart';
import 'package:tutoring_app_2/app/modules/chats/domain/models/user.dart';
import 'package:tutoring_app_2/app/modules/one_to_one_chat/views/messaging_body_view.dart';

class OneToOneMessagingScreen extends StatelessWidget {
  const OneToOneMessagingScreen({super.key, required this.theuser});
  final UserModel theuser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(theuser.username.toString()),
      ),
      body: MessagingBodyView(user: theuser),
    );
  }
}
