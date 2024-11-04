import 'package:boxed_project/route_structure/go_router.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _routes = RouteName();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Boxed Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Palette.themecolor,
        ),
        fontFamily: Constants.appFontFamily,
        useMaterial3: true,
      ),
      routerConfig: _routes.myrouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        maxWidth: double.infinity,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.resize(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: TABLET),
          const ResponsiveBreakpoint.autoScale(double.infinity, name: DESKTOP),
        ],
      ),
    );
  }
}
