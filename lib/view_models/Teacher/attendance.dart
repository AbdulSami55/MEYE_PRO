// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Teacher/attendance.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Teacher/attendance.dart';
import 'package:live_streaming/repo/api_status.dart';

class AttendanceViewModel with ChangeNotifier {
  var _lstAttendance = <Attendance>[];
  bool _isloading = false;
  UserError? _userError;

  List<Attendance> get lstAttendance => _lstAttendance;
  bool get isloading => _isloading;
  UserError? get userError => _userError;

  setListAttendance(List<Attendance> lst) {
    List<Attendance> temp = [];
    for (Attendance attendance in lst) {
      if (attendance.status == false) {
        temp.add(attendance);
      }
    }
    for (Attendance attendance in lst) {
      if (attendance.status) {
        temp.add(attendance);
      }
    }
    _lstAttendance = temp;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  markAttendance(File file) async {
    setloading(true);
    _lstAttendance = [];
    _userError = null;
    var response = await AttendanceServices.markAttendance(file);
    if (response is Success) {
      setListAttendance(response.response as List<Attendance>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
