// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/routes.dart';

import 'package:live_streaming/view_models/Admin/dvr_view_model.dart';
import 'package:live_streaming/view_models/Admin/reschedule_view_model.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/view_models/Admin/user_view_model.dart';
import 'package:live_streaming/view_models/Admin/venue_view_model.dart';
import 'package:live_streaming/view_models/handle_bottom_nav.dart';
import 'package:provider/provider.dart';
import 'Model/Admin/ip.dart';

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
         ChangeNotifierProvider(create: (_) => BottomNavViewModel()),
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
