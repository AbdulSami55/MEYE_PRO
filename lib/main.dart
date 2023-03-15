// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/routes.dart';

import 'package:live_streaming/view_models/Admin/DVR/dvr_view_model.dart';
import 'package:live_streaming/view_models/Admin/Profile/rule_setting_view_model.dart';
import 'package:live_streaming/view_models/Admin/reschedule_view_model.dart';
import 'package:live_streaming/view_models/Admin/User/user_view_model.dart';
import 'package:live_streaming/view_models/Admin/venue_view_model.dart';
import 'package:live_streaming/view_models/handle_bottom_nav.dart';
import 'package:live_streaming/view_models/signin_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

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
        ChangeNotifierProvider(create: (_) => ReScheduleViewModel()),
        ChangeNotifierProvider(create: (_) => RuleSettingViewModel()),
        ChangeNotifierProvider(create: (_) => BottomNavViewModel()),
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green, primaryColor: Colors.green[400]),
        title: title,
      ),
    );
  }
}
