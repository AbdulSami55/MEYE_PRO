// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Screens/bottomnav.dart';
import 'package:live_streaming/view_models/dvr_view_model.dart';
import 'package:provider/provider.dart';
import 'Model/Admin/ip.dart';
import 'Screens/Admin/onboding/onboding_screen.dart';

void main() {
  // Connect();
  runApp(const MyApp());
}

Connect() {
  try {
    NetworkIP.Connect();
  } catch (e) {
    print(e);
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const OnbodingScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'AdminHome',
          builder: (BuildContext context, GoRouterState state) {
            return const BottomNavBar();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var title = 'MEYE PRO';
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DVRViewModel())],
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green, primaryColor: Colors.green[400]),
        title: title,
      ),
    );
  }
}
