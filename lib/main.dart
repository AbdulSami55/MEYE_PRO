// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Screens/login.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:velocity_x/velocity_x.dart';

import 'Model/Admin/ip.dart';
import 'Screens/bottomnav.dart';

void main() {
  Connect();
  runApp(VxState(store: MyStore(), child: const MyApp()));
}

Connect() {
  NetworkIP.Connect();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var title = 'MEYE PRO';
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            primaryColor: Colors.orange,
            brightness: Brightness.dark),
        title: title,
        home: const BottomNavBar());
  }
}
