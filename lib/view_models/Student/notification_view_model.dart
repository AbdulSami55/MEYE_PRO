// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Student/student_notification.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Student/student_notification_services.dart';
import 'package:live_streaming/repo/api_status.dart';

class StudentNotificationViewModel with ChangeNotifier {
  var _lststudentNotification = <StudentNotification>[];
  bool _isloading = false;
  UserError? _userError;
  int selectedIndex = -1;

  List<StudentNotification> get lststudentNotification =>
      _lststudentNotification;
  bool get isloading => _isloading;
  UserError? get userError => _userError;

  setListStudentNotification(List<StudentNotification> lst) {
    _lststudentNotification = lst;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  getStudentNotification(String aridNumber) async {
    setloading(true);
    var response =
        await StudentNotificationServies.getStudentNotification(aridNumber);
    if (response is Success) {
      setListStudentNotification(
          response.response as List<StudentNotification>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
