import 'package:flutter/material.dart';
import 'package:tutoring_app_2/app/core/extensions/build_context_ext.dart';

abstract class navbarItems {
  static List<BottomNavigationBarItem> navtabs(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.message_outlined),
        label: context.translate.chats,
        activeIcon: const Icon(
          Icons.message_outlined,
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: context.translate.profile,
        activeIcon: Icon(Icons.person),
      )
    ];
  }
}
