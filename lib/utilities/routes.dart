import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Screens/Admin/Profile/add_user.dart';
import 'package:live_streaming/Screens/Admin/Teacher/teacher_details.dart';
import 'package:live_streaming/Screens/Tecaher/attendance.dart';
import 'package:live_streaming/Screens/Tecaher/bottom_nav.dart';
import 'package:live_streaming/Screens/Tecaher/home_screen.dart';

import 'package:live_streaming/Screens/Admin/bottomnav.dart';
import '../Screens/onboding/onboding_screen.dart';
import '../Screens/Student/home_screen.dart';

final GoRouter router = GoRouter(
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
        GoRoute(
            path: 'AddUser', builder: ((context, state) => const AddUser())),
        GoRoute(
            path: 'StudentDashboard',
            builder: ((context, state) => const StudentDashboard())),
        GoRoute(
            path: 'TeacherDashboard',
            builder: ((context, state) => const TeacherDashboard())),
        GoRoute(
            path: 'TeacherBottomNavBar',
            builder: ((context, state) => const TeacherBottomNav())),
        GoRoute(
            path: 'AttendanceCamera',
            builder: ((context, state) => const AttendanceCamera())),
      ],
    ),
  ],
);
