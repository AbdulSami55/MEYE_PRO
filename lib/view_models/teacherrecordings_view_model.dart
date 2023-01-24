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
  String filter = "Section";

  bool get loading => _isloading;
  UserError? get userError => _userError;
  TeacherRecordings get teacherrecordings => _teacherrecordings;
  TeacherRecordings? tempteacherrecordings = TeacherRecordings();
  TeacherRecordingsViewModel(int teacherid) {
    getData(teacherid);
  }
  setloading(bool loading) async {
    _isloading = loading;
    notifyListeners();
  }

  void setFilter(String value) {
    if (value != "") {
      if (filter == "Date") {
        tempteacherrecordings!.recordings = teacherrecordings.recordings!
            .where((element) => element.date.toString().contains(value))
            .toList();
      } else if (filter == "Type") {
        tempteacherrecordings!.recordings = teacherrecordings.recordings!
            .where((element) => element.filename.toString().contains(value))
            .toList();
      } else if (filter == "Section") {
        tempteacherrecordings!.section = teacherrecordings.section!
            .where((element) => element.name.toString().contains(value))
            .toList();
      } else if (filter == "Course") {
        tempteacherrecordings!.course = teacherrecordings.course!
            .where((element) => element.name.toString().contains(value))
            .toList();
      }
    } else {
      tempteacherrecordings!.recordings = teacherrecordings.recordings;
      tempteacherrecordings!.course = teacherrecordings.course;
      tempteacherrecordings!.section = teacherrecordings.section;
      tempteacherrecordings!.teacherslot = teacherrecordings.teacherslot;
      tempteacherrecordings!.timetable = teacherrecordings.timetable;
    }
    notifyListeners();
  }

  void setTeacherRecordings(TeacherRecordings teacherrecordings) {
    _teacherrecordings = teacherrecordings;
    tempteacherrecordings!.recordings = teacherrecordings.recordings;
    tempteacherrecordings!.course = teacherrecordings.course;
    tempteacherrecordings!.section = teacherrecordings.section;
    tempteacherrecordings!.teacherslot = teacherrecordings.teacherslot;
    tempteacherrecordings!.timetable = teacherrecordings.timetable;
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
