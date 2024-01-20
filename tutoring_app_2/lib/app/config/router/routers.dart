import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tutoring_app_2/app/config/router/my_named_route.dart';
import 'package:tutoring_app_2/app/modules/chats/view/home.dart';
import 'package:tutoring_app_2/app/modules/auth/views/login.dart';
import 'package:tutoring_app_2/app/modules/auth/views/register.dart';
import 'package:tutoring_app_2/app/modules/auth/views/splashscreen.dart';
import 'package:tutoring_app_2/app/modules/navbar/view/navbar_scaffold.dart';
import 'package:tutoring_app_2/app/modules/navbar/widget/navbar_widget.dart';
import 'package:tutoring_app_2/app/modules/profile/profile_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final shellRouteKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const SizedBox();

  /// use this in [MaterialApp.router]
  static final _router = GoRouter(
    initialLocation: MyNamedRoutes.root,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // outside the [ShellRoute] to make the screen on top of the [BottomNavBar]
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: MyNamedRoutes.root,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.login}",
        name: MyNamedRoutes.login,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.register}",
        name: MyNamedRoutes.register,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: RegisterPage(),
        ),
      ),

      ShellRoute(
        navigatorKey: shellRouteKey,
        builder: (context, state, child) {
          return navbarPage(
            navtabs: navbarItems.navtabs(context),
            child: child,
          );
        },
        routes: [
          /// home route
          GoRoute(
              path: "/${MyNamedRoutes.chats}",
              name: MyNamedRoutes.chats,
              pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: HomePage(),
                  ),
              routes: []),

          /// profile route
          GoRoute(
            path: "/${MyNamedRoutes.profile}",
            name: MyNamedRoutes.profile,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
