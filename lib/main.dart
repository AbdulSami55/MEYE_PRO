// ignore_for_file: dead_code, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Screens/bottomnav.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'Controller/dvr.dart';
import 'Model/Admin/ip.dart';

void main() {
  // Connect();
  runApp(VxState(store: MyStore(), child: const MyApp()));
}

Connect() {
  try {
    NetworkIP.Connect();
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var title = 'MEYE PRO';
    return ChangeNotifierProvider(
      create: ((context) => DVRController()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.green, primaryColor: Colors.green[400]),
          title: title,
          home: const BottomNavBar()),
    );
  }
}
