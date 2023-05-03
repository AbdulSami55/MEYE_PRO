// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, file_names

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/schedule.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/repo/Admin/reschedule_service.dart';

import '../../Model/Admin/venue.dart';
import '../../Model/user_error.dart';
import '../../repo/api_status.dart';

class ReScheduleViewModel extends ChangeNotifier {
  bool _loading = true;
  var _lsttimetable = <TimeTable>[];
  UserError? _userError;
  Venue? _selectedvalue;
  int teacherSlotId = -1;
  String Daytime = '';
  String mon8 = "",
      mon10 = "",
      mon11 = "",
      mon1 = "",
      mon3 = "",
      tue8 = "",
      tue10 = "",
      tue11 = "",
      tue1 = "",
      tue3 = "",
      wed8 = "",
      wed10 = "",
      wed11 = "",
      wed1 = "",
      wed3 = "",
      thu8 = "",
      thu10 = "",
      thu11 = "",
      thu1 = "",
      thu3 = "",
      fri8 = "",
      fri10 = "",
      fri11 = "",
      fri1 = "",
      fri3 = "";

  UserError? get userError => _userError;
  List<TimeTable> get lsttimetable => _lsttimetable;
  bool get loading => _loading;
  Venue? get selectedvalue => _selectedvalue;

  void setlsttimetable(List<TimeTable> lst, String discipline) async {
    _lsttimetable = lst;
  }

  void changeSelectedValue(Venue? v) {
    _selectedvalue = v;
    notifyListeners();
  }

  void setloading(bool load) {
    _loading = load;
    notifyListeners();
  }

  void setUserError(UserError? userError) {
    _userError = userError;
  }

  void getdata(String startdate, String enddate, String discipline) async {
    setUserError(null);
    setloading(true);
    var response = await RescheduleServies.getTimetable(startdate, enddate);
    if (response is Success) {
      setlsttimetable(response.response as List<TimeTable>, discipline);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

  Future<String> checkTeacherRescheduleClass(String teacherName) async {
    teacherSlotId = -1;
    var response =
        await RescheduleServies.checkTeacherRescheduleClass(teacherName);
    if (response is Success) {
      if (response.response.toString() != 'No Class Missed') {
        teacherSlotId = response.response as int;
        return 'okay';
      }
      return response.response as String;
    } else if (response is Failure) {
      return response.errorResponse.toString();
    }
    return "Something Went Wrong";
  }

  Future insertdata(Schedule schedule) async {
    setloading(true);
    setUserError(null);
    var response = await RescheduleServies.post(schedule);
    if (response is Success) {
      String data = response.response as String;
      if (data != "okay") {
        UserError userError = UserError(code: response.code, message: data);
        setUserError(userError);
      }
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
