// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/repo/Admin/reschedule_service.dart';

import '../Model/Admin/venue.dart';
import '../Model/user_error.dart';
import '../repo/api_status.dart';

class ReScheduleViewModel extends ChangeNotifier {
  bool _loading = true;
  var _lsttimetable = <TimeTable>[];
  UserError? _userError;
  Venue? _selectedvalue;

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

  ReScheduleViewModel() {
    getdata();
  }
  void setlsttimetable(List<TimeTable> lst) async {
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

  void setUserError(UserError userError) {
    _userError = userError;
  }

  void getdata() async {
    setloading(true);
    var response = await RescheduleServies.getTimetable();
    if (response is Success) {
      setlsttimetable(response.response as List<TimeTable>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
