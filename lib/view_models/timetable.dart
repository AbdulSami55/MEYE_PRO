// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/course.dart';
import 'package:live_streaming/Model/Admin/fulltimetable.dart';
import 'package:live_streaming/Model/Admin/section.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/repo/Admin/timetable_services.dart';
import '../Model/user_error.dart';
import '../repo/api_status.dart';

class TimetableViewModel extends ChangeNotifier {
  bool _loading = true;
  var _lsttimetable = <TimeTable>[];
  UserError? _userError;
  TimeTable? _timeTable;
  var _lstfulltimetable = <FullTimeTable>[];
  UserError? get userError => _userError;
  List<TimeTable> get lsttimetable => _lsttimetable;
  bool get loading => _loading;
  TimeTable? get timetable => _timeTable;
  List<FullTimeTable> get lstfulltimetable => _lstfulltimetable;

  void setlsttimetable(List<TimeTable> lst) {
    _lsttimetable = lst;
  }

  void emptylst() {
    _lstfulltimetable = [];
    _userError = null;
  }

  void setdata(String data) {
    var val = json.decode(data);
    FullTimeTable fullTimeTable = FullTimeTable();
    fullTimeTable.timeTable = timeTableFromJson(val["timetable"]);
    fullTimeTable.course = courseFromJson(val["course"]);
    fullTimeTable.section = sectionFromJson(val["section"]);
    fullTimeTable.venue = singlevenueFromJson(val["venue"]);
    _lstfulltimetable.add(fullTimeTable);
  }

  void setloading(bool load) {
    _loading = load;
    notifyListeners();
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  getdata(int id) async {
    setloading(true);
    var response = await TimeTableServices().gettimetable(id);
    if (response is Success) {
      setdata(response.response.toString());
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
