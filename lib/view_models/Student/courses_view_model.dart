// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Student/course_attendance.dart';
import 'package:live_streaming/Model/Student/student_courses.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Student/student_course_service.dart';
import 'package:live_streaming/repo/api_status.dart';

class CourseViewModel with ChangeNotifier {
  var _lstcourses = <StudentCourses>[];
  var _lstCourseAttendance = <CourseAttendance>[];
  bool _isloading = false;
  UserError? _userError;
  int selectedIndex = -1;

  List<StudentCourses> get lstcourses => _lstcourses;
  List<CourseAttendance> get lstCourseAttendance => _lstCourseAttendance;
  bool get isloading => _isloading;
  UserError? get userError => _userError;
  CourseViewModel(String aridNumber) {
    getCourse(aridNumber);
  }
  setListCourse(List<StudentCourses> lst) {
    _lstcourses = lst;
  }

  setListCourseAttendance(List<CourseAttendance> lst) {
    _lstCourseAttendance = lst;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  getCourse(String aridNumber) async {
    setloading(true);
    var response = await StudentCourseServies.getCourse(aridNumber);
    if (response is Success) {
      setListCourse(response.response as List<StudentCourses>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }

  getCourseAttendace(String aridNumber, String courseName) async {
    setloading(true);
    var response =
        await StudentCourseServies.getCourseAttedance(aridNumber, courseName);
    if (response is Success) {
      setListCourseAttendance(response.response as List<CourseAttendance>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
    }
    setloading(false);
  }
}
