// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:live_streaming/Model/Student/student_courses.dart';
import 'package:live_streaming/Model/user_error.dart';
import 'package:live_streaming/repo/Student/student_course_service.dart';
import 'package:live_streaming/repo/api_status.dart';

class CourseViewModel with ChangeNotifier {
  var _lstcourses = <StudentCourses>[];
  bool _isloading = false;
  UserError? _userError;

  List<StudentCourses> get lstcourses => _lstcourses;
  bool get isloading => _isloading;
  UserError? get userError => _userError;
  CourseViewModel(String aridNumber) {
    getCourse(aridNumber);
  }
  setListCourse(List<StudentCourses> lst) {
    _lstcourses = lst;
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
}
