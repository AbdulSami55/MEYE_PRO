// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:live_streaming/Notification/push_notification.dart';
import 'package:live_streaming/firebase_options.dart';
import 'package:live_streaming/utilities/routes.dart';

import 'package:live_streaming/view_models/Admin/DVR/dvr_view_model.dart';
import 'package:live_streaming/view_models/Admin/Profile/rule_setting_view_model.dart';
import 'package:live_streaming/view_models/Admin/reschedule_view_model.dart';
import 'package:live_streaming/view_models/Admin/User/user_view_model.dart';
import 'package:live_streaming/view_models/Admin/swapping_view_model.dart';
import 'package:live_streaming/view_models/Admin/venue_view_model.dart';
import 'package:live_streaming/view_models/Teacher/attendance.dart';
import 'package:live_streaming/view_models/handle_bottom_nav.dart';
import 'package:live_streaming/view_models/signin_view_model.dart';
import 'package:provider/provider.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  initialize();
  runApp(const MyApp());
}

initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('mipmap/app_icon');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificationService notificationService = PushNotificationService();
  await notificationService.initialize();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      initialize();
    } else if (state == AppLifecycleState.resumed) {
      initialize();
    } else if (state == AppLifecycleState.inactive) {
      initialize();
    } else if (state == AppLifecycleState.detached) {
      initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DVRViewModel()),
        ChangeNotifierProvider(create: (_) => VenueViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ReScheduleViewModel()),
        ChangeNotifierProvider(create: (_) => RuleSettingViewModel()),
        ChangeNotifierProvider(create: (_) => BottomNavViewModel()),
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
        ChangeNotifierProvider(create: (_) => AttendanceViewModel()),
        ChangeNotifierProvider(create: (_) => SwappingViewModel())
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green, primaryColor: Colors.green[400]),
        title: 'MEYE PRO',
      ),
    );
  }
}
