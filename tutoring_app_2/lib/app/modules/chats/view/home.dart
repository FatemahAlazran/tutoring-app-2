import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutoring_app_2/app/config/router/my_named_route.dart';
import 'package:tutoring_app_2/app/config/theme/my_colors.dart';
import 'package:tutoring_app_2/app/core/extensions/build_context_ext.dart';
import 'package:tutoring_app_2/app/modules/auth/domain/providers/auth_provider.dart';
import 'package:tutoring_app_2/app/modules/chats/domain/models/user.dart';
import 'package:tutoring_app_2/app/modules/chats/domain/providers/chat_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatUsers = ref.watch(usersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.chats),
      ),
      body: chatUsers.when(data: (List<UserModel> data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  GoRouter.of(context)
                      .pushNamed(MyNamedRoutes.chatDetails, extra: data[index]);
                },
                title: Text(data[index].username.toString()),
                subtitle: Text(data[index].email),
                tileColor: MyColors.greyscale_100,
              ),
            );
          },
        );
      }, error: (Object error, StackTrace stackTrace) {
        return Center(child: Text(error.toString()));
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
