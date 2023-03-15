import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Screens/Admin/Profile/AssignCourse/student_list.dart';
import 'package:live_streaming/Screens/Admin/Profile/add_user.dart';
import 'package:live_streaming/Screens/Admin/Profile/AssignCourse/assign_course.dart';
import 'package:live_streaming/Screens/Admin/Profile/profile.dart';
import 'package:live_streaming/Screens/Admin/Profile/rule_setting.dart';
import 'package:live_streaming/Screens/Admin/Teacher/teacher_details.dart';
import 'package:live_streaming/Screens/Admin/live_stream_details.dart';
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
        GoRoute(
            path: 'Profile', builder: ((context, state) => const Profile())),
        GoRoute(
            path: 'LiveStreamDetails',
            builder: ((context, state) => const LiveStreamingDetails())),
        GoRoute(
            path: 'AssignCourse',
            builder: ((context, state) => const AssignCourse())),
        GoRoute(
            path: 'RuleSetting',
            builder: ((context, state) {
              User user = state.extra as User;
              return RuleSetting(user: user);
            })),
        GoRoute(
            path: 'TeacherDetails/:isRuleSetting',
            name: 'TeacherDetails',
            builder: ((context, state) => TeacherDetails(
                  isRuleSetting: state.params['isRuleSetting'],
                ))),
        GoRoute(
            path: 'StudentCourseOffered/:lstcourse/:sectionOfferId',
            name: 'StudentCourseOffered',
            builder: ((context, state) => StudentCourseOffered(
                  lstcourse: state.params['lstcourse']!,
                  sectionOfferId: state.params['sectionOfferId']!,
                )))
      ],
    ),
  ],
);
