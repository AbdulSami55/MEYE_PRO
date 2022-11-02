// ignore_for_file: prefer_is_empty

import 'dart:io';

import 'package:velocity_x/velocity_x.dart';

import '../Model/Admin/Camera/Camera.dart';

class MyStore extends VxStore {
  List<Camera>? lstcamera = [];
  File? image;
}
