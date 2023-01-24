// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Admin/teacherrecordings.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Admin/teacher_recording_services.dart';
import 'package:live_streaming/repo/api_status.dart';

class TeacherRecordingsViewModel with ChangeNotifier {
  bool _isloading = false;
  var _teacherrecordings;
  UserError? _userError;
  String prevcoursename = "";

  bool get loading => _isloading;
  UserError? get userError => _userError;
  TeacherRecordings get teacherrecordings => _teacherrecordings;

  TeacherRecordingsViewModel(int teacherid) {
    getData(teacherid);
  }
  setloading(bool loading) async {
    _isloading = loading;
    notifyListeners();
  }

  void setTeacherRecordings(TeacherRecordings teacherrecordings) {
    _teacherrecordings = teacherrecordings;
  }

  void setUserError(UserError userError) {
    _userError = userError;
  }

  getData(int teacherid) async {
    setloading(true);
    var response = await TeacherRecordingServies.getRecordings(teacherid);
    if (response is Success) {
      setTeacherRecordings(response.response as TeacherRecordings);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
