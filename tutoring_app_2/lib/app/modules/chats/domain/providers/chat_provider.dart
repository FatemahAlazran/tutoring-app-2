import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutoring_app_2/app/modules/chats/domain/models/user.dart';
import 'package:tutoring_app_2/app/modules/chats/domain/repo/chat_repo.dart';

final chatsRepositoryProvider = Provider((ref) => ChatsRepo());

final usersProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  final chatsRepo = ref.watch(chatsRepositoryProvider);
  debugPrint("*******");
  try {
    final userList = await chatsRepo.fetchUsers();
    return userList;
  } catch (e) {
    debugPrint('Error fetching users: $e');
    return [];
  }
});
