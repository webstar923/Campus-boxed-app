import 'package:boxed_project/views/auth/forgot_password/forgot_password_screen.dart';
import 'package:boxed_project/views/auth/login_screen.dart';
import 'package:boxed_project/views/auth/signup_screen.dart';
import 'package:boxed_project/views/home/home_screen.dart';
import 'package:boxed_project/views/navbar/nav_bar.dart';
import 'package:boxed_project/views/splash/splash_screen.dart';
import 'package:boxed_project/views/welcome/welcome_screen.dart';
import 'package:boxed_project/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteName {
  static const String splashScreen = 'splash';
  static const String welcomeScreen = 'welcome';
  static const String loginScreen = 'login';
  static const String signupScreen = 'sign-up';
  static const String forgotPasswordScreen = 'forgot-password';
  static const String navbar = 'nav-bar';
  static const String homeScreen = 'home';
  static const String chatScreen = 'chat';
  static const String profileScreen = 'profile';

  GoRouter myrouter = GoRouter(
    errorPageBuilder: (context, state) {
      return const MaterialPage(
        child: ErrorScreen(),
      );
    },
    routes: [
      GoRoute(
        path: '/',
        name: splashScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: '/$welcomeScreen',
        name: welcomeScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: WelcomeScreen(),
          );
        },
      ),
      GoRoute(
        path: '/$loginScreen',
        name: loginScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: '/$signupScreen',
        name: signupScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SignupScreen(),
          );
        },
      ),
      GoRoute(
        path: '/$forgotPasswordScreen',
        name: forgotPasswordScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ForgotPasswordScreen(),
          );
        },
      ),
      GoRoute(
        path: '/$navbar/:currentIndex',
        name: navbar,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: NavBar(
              currentIndex: state.pathParameters['currentIndex'] ?? '',
            ),
          );
        },
      ),
      GoRoute(
        path: '/$homeScreen',
        name: homeScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: HomeScreen(),
          );
        },
      ),
      // GoRoute(
      //   path: '/$categorieScreen',
      //   name: categorieScreen,
      //   pageBuilder: (context, state) {
      //     return const MaterialPage(
      //       child: CategoriesScreen(),
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: '/$chatScreen',
      //   name: chatScreen,
      //   pageBuilder: (context, state) {
      //     return const MaterialPage(
      //       child: ChatScreen(),
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: '/$bookingScreen',
      //   name: bookingScreen,
      //   pageBuilder: (context, state) {
      //     return const MaterialPage(
      //       child: BookingsScreen(),
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: '/$profileScreen',
      //   name: profileScreen,
      //   pageBuilder: (context, state) {
      //     return const MaterialPage(
      //       child: ProfileScreen(),
      //     );
      //   },
      // ),
    ],
  );
}
