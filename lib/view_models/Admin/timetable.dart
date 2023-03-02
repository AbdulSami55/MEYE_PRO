// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/repo/Admin/timetable_services.dart';
import '../../Model/user_error.dart';
import '../../repo/api_status.dart';

class TimetableViewModel extends ChangeNotifier {
  bool _loading = true;
  var _lsttimetable = <TimeTable>[];
  UserError? _userError;
  TimeTable? _timeTable;
  UserError? get userError => _userError;
  List<TimeTable> get lsttimetable => _lsttimetable;
  bool get loading => _loading;
  TimeTable? get timetable => _timeTable;

  TimetableViewModel(String teacherName) {
    if (teacherName.split(' ')[0] == "Mr") {
      teacherName = teacherName.substring(3, teacherName.length);
    }
    getdata(teacherName);
  }

  void setlsttimetable(List<TimeTable> lst) {
    _lsttimetable = lst;
  }

  void emptylst() {
    _userError = null;
  }

  void setdata(List<TimeTable> lst) {
    // var val = json.decode(data);
    // FullTimeTable fullTimeTable = FullTimeTable();
    // fullTimeTable.timeTable = timeTableFromJson(val["timetable"]);
    // fullTimeTable.course = courseFromJson(val["course"]);
    // fullTimeTable.section = sectionFromJson(val["section"]);
    // fullTimeTable.venue = singlevenueFromJson(val["venue"]);
    _lsttimetable = lst;
  }

  void setloading(bool load) {
    _loading = load;
    notifyListeners();
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  getdata(String teacherName) async {
    setloading(true);
    var response = await TimeTableServices().gettimetable(teacherName);
    if (response is Success) {
      setdata(response.response as List<TimeTable>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
