// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const Color backgroundColor2 = Color(0xFF17203A);
const Color backgroundColorLight = Color(0xFFF2F6FF);
const Color backgroundColorDark = Color(0xFF25254B);
const Color shadowColorLight = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;
const Color primaryColor = Colors.green;
Color? backgroundColor = Colors.grey[300];
const Color containerColor = Colors.white;

//-------------------------Errors------------------------------
const INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;
//------------------------------------URLS---------------------
const String baseUrl = 'http://192.168.0.111:8000';
const String addadvrurl = '$baseUrl/api/add-dvr';
const String getdvrurl = '$baseUrl/api/dvr-details';
const String addcameraurl = '$baseUrl/api/add-camera';
const String getcamera = '$baseUrl/api/camera-details/';
const String getvenue = '$baseUrl/api/venue-details';
