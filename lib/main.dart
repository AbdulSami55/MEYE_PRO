// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Screens/Admin/Profile/add_user.dart';
import 'package:live_streaming/Screens/Admin/Teacher/teacher_details.dart';
import 'package:live_streaming/Screens/bottomnav.dart';
import 'package:live_streaming/view_models/dvr_view_model.dart';
import 'package:live_streaming/view_models/reschedule_view_model.dart';
import 'package:live_streaming/view_models/timetable.dart';
import 'package:live_streaming/view_models/user_view_model.dart';
import 'package:live_streaming/view_models/venue_view_model.dart';
import 'package:provider/provider.dart';
import 'Model/Admin/ip.dart';
import 'Screens/Admin/onboding/onboding_screen.dart';

void main() {
  Connect();
  runApp(const MyApp());
}

Connect() {
  try {
    NetworkIP.Connect();
  } catch (e) {
    //
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
        GoRoute(
            path: 'TeacherDetails',
            builder: ((context, state) => TeacherDetails())),
        GoRoute(path: 'AddUser', builder: ((context, state) => const AddUser()))
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
      providers: [
        ChangeNotifierProvider(create: (_) => DVRViewModel()),
        ChangeNotifierProvider(create: (_) => VenueViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => TimetableViewModel()),
        ChangeNotifierProvider(create: (_) => ReScheduleViewModel()),
      ],
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
