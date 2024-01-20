import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tutoring_app_2/app/config/router/my_named_route.dart';
import 'package:tutoring_app_2/app/config/theme/my_colors.dart';
import 'package:tutoring_app_2/app/core/extensions/build_context_ext.dart';

class navbarPage extends StatefulWidget {
  const navbarPage({super.key, required this.navtabs, required this.child});

  final List<BottomNavigationBarItem> navtabs;
  final Widget child;

  @override
  State<navbarPage> createState() => _navbarPageState();
}

class _navbarPageState extends State<navbarPage> {
  _calculateCurrentIndex(context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/${MyNamedRoutes.chats}')) {
      return 0;
    } else if (location.startsWith('/${MyNamedRoutes.profile}')) {
      return 1;
    }
    return 0;
  }

  onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/${MyNamedRoutes.chats}');
        break;
      case 1:
        GoRouter.of(context).go('/${MyNamedRoutes.profile}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
        ],
        backgroundColor: MyColors.secondary_500,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColors.primary_500,
        unselectedItemColor: MyColors.greyscale_500,
        selectedLabelStyle: context.textTheme.bodyMedium?.copyWith(
          color: MyColors.primary_500,
        ),
        unselectedLabelStyle: context.textTheme.bodyMedium
            ?.copyWith(color: MyColors.greyscale_500),
        onTap: (index) => onItemTapped(index, context),
        currentIndex: _calculateCurrentIndex(context),
      ),
    );
  }
}
