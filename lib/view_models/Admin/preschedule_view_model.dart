// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/preschedule.dart';
import 'package:live_streaming/repo/Admin/preschedule_service.dart';
import '../../Model/user_error.dart';
import '../../repo/api_status.dart';

class PreScheduleViewModel extends ChangeNotifier {
  bool _loading = true;

  List<PreSchedule> lstPreScheduleSlot = [];
  UserError? _userError;

  UserError? get userError => _userError;
  bool get loading => _loading;

  void setloading(bool load) {
    _loading = load;
    notifyListeners();
  }

  void setUserError(UserError? userError) {
    _userError = userError;
  }

  Future insertdata(PreSchedule schedule) async {
    setloading(true);
    setUserError(null);
    var response = await PreScheduleServies.post(schedule);
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
