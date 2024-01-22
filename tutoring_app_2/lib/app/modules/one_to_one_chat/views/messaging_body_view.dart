import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutoring_app_2/app/core/extensions/build_context_ext.dart';
import 'package:tutoring_app_2/app/modules/chats/domain/models/user.dart';
import 'package:tutoring_app_2/app/modules/one_to_one_chat/domain/models/message.dart';
import 'package:tutoring_app_2/app/modules/one_to_one_chat/domain/providers/message_provider.dart';
import 'package:tutoring_app_2/app/modules/one_to_one_chat/domain/repo/message_repo.dart';
import 'package:tutoring_app_2/app/modules/one_to_one_chat/widget/message_bubble.dart';

class MessagingBodyView extends ConsumerStatefulWidget {
  final UserModel user;

  const MessagingBodyView({super.key, required this.user});

  @override
  ConsumerState<MessagingBodyView> createState() => _MessagingBodyViewState();
}

class _MessagingBodyViewState extends ConsumerState<MessagingBodyView> {
  final _sendMessageController = TextEditingController();
  @override
  void dispose() {
    _sendMessageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final messagingRepo = ref.watch(messagingProvider);
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<Message>>(
            stream: messagingRepo.messagesStream(
              senderId: currentUserId,
              receiverId: widget.user.id,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return Center(
                    child: Text('Error fetching messages: ${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final messages = snapshot.data ?? [];
              return ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) =>
                    MessageBubble(message: messages[index]),
              );
            },
          ),
        ),
        _buildMessageInput(context, widget.user.id, messagingRepo),
      ],
    );
  }

  Widget _buildMessageInput(
      BuildContext context, String userId, MessagingRepository messagingRepo) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _sendMessageController,
              decoration: const InputDecoration(hintText: 'Type your message'),
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                await messagingRepo
                    .sendMessage(
                  senderId: FirebaseAuth.instance.currentUser!.uid,
                  receiverId: userId,
                  message: _sendMessageController.text,
                )
                    .whenComplete(() {
                  _sendMessageController.clear();
                });
              } catch (e) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  context.showSnackbar(
                    'Error sending message: $e',
                  );
                });
              }
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
