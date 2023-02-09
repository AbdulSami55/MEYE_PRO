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
//------------------------Font Size---------------------------
const MediumFontSize = 25;
//-------------------------Errors------------------------------
const INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;
//------------------------------------URLS---------------------

const String baseUrl = 'http://192.168.43.192:8000';
const String addadvrurl = '$baseUrl/api/add-dvr';
const String getdvrurl = '$baseUrl/api/dvr-details';
const String addcameraurl = '$baseUrl/api/add-camera';
const String getcamera = '$baseUrl/api/camera-details/';
const String getvenue = '$baseUrl/api/venue-details';
const String adduser = '$baseUrl/api/add-user';
const String getuser = '$baseUrl/api/user-details';
const String getuserimage = '$baseUrl/api/get-user-image/UserImages/';
const String gettimetableurl = '$baseUrl/api/timetable-details/';
const String getteachurl = '$baseUrl/api/teach-details/';
const String gettimetable = '$baseUrl/api/get-timetable';
const String addreschedule = '$baseUrl/api/add-reschedule';
const String getteacherrecordings =
    '$baseUrl/api/recordings-details-by-teacherid/';
const String getvideo = '$baseUrl/video?path=';
