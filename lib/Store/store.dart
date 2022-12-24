// ignore_for_file: prefer_is_empty

import 'dart:io';
import 'package:live_streaming/Model/Admin/Camera/camera.dart';
import 'package:live_streaming/Model/Admin/schedule.dart';
import 'package:live_streaming/Model/Teacher/teacher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Model/Admin/DVR/dvr.dart';

class MyStore extends VxStore {
  List<DVR>? lstDVR = [];
  List<Camera>? lstCamera = [];
  List<TeacherData>? lstteacher = [];
  File? image;
  TeacherSchedule? teacherSchedule;
  int? scheduleindex;
  List<String>? lstchannel = [];
  String? channel;
  Camera? oldcamera;
}
