import 'package:flutter/material.dart';
import 'package:tutoring_app_2/app/modules/chats/domain/models/user.dart';
import 'package:tutoring_app_2/app/modules/one_to_one_chat/views/messaging_body_view.dart';

class OneToOneMessagingScreen extends StatelessWidget {
  final User user;

  const OneToOneMessagingScreen({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username.toString()),
      ),
      body: MessagingBodyView(selectedUser: user),
    );
  }
}
