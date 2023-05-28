// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/swapping.dart';
import 'package:live_streaming/repo/Admin/swapping_service.dart';
import '../../Model/user_error.dart';
import '../../repo/api_status.dart';

class SwappingViewModel extends ChangeNotifier {
  bool _loading = true;

  var _lstSwappingUserSlot = <SwappingUser>[];
  UserError? _userError;

  UserError? get userError => _userError;
  bool get loading => _loading;
  List<SwappingUser> get lstSwappingUserSlot => _lstSwappingUserSlot;

  void setlstSwappingUser(List<SwappingUser> lst) {
    _lstSwappingUserSlot = lst;
  }

  void setloading(bool load) {
    _loading = load;
    notifyListeners();
  }

  void setUserError(UserError? userError) {
    _userError = userError;
  }

  Future getdata(
      String day, String startTime, String endTime, int timeTableId) async {
    setloading(true);
    setUserError(null);
    var response =
        await SwappingServies.getData(day, startTime, endTime, timeTableId);
    if (response is Success) {
      if (response.response == 'Class Already Swapped') {
        UserError userError =
            UserError(code: response.code, message: 'Class Already Swapped');
        setUserError(userError);
      } else {
        setlstSwappingUser(response.response as List<SwappingUser>);
      }
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

  Future insertdata(Swapping swapping) async {
    var response = await SwappingServies.insertSwapping(swapping);
    if (response is Success) {
      String data = response.response as String;
      if (data == "okay") {
        return data;
      } else {
        return "Error";
      }
    }
    if (response is Failure) {
      return "Error";
    }
  }
}
