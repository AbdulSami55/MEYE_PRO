import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Student/course_attendance.dart';
import 'package:live_streaming/Model/Student/student_courses.dart';
import '../../utilities/constants.dart';
import '../api_status.dart';

class StudentCourseServies {
  static Future<Object> getCourse(String aridNumber) async {
    try {
      var response = await http.get(
          Uri.parse("$getCourseurl?aridNumber=$aridNumber"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        return Success(response: studentCoursesFromJson(response.body));
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Response");
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(
          code: UNKNOWN_ERROR, errorResponse: "Something Went Wrong");
    }
  }

  static Future<Object> getCourseAttedance(
      String aridNumber, String courseName) async {
    try {
      var response = await http.get(
          Uri.parse(
              "$getCourseAttendanceurl?aridNumber=$aridNumber&courseName=$courseName"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        return Success(response: courseAttendanceFromJson(response.body));
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Response");
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(
          code: UNKNOWN_ERROR, errorResponse: "Something Went Wrong");
    }
  }

  static Future<Object> getAttendanceNotification(String aridNumber) async {
    try {
      var response = await http.get(
          Uri.parse("$getAttendanceNotificationurl?aridNumber=$aridNumber"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        return Success(response: jsonDecode(response.body));
      }
      return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Response");
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(
          code: UNKNOWN_ERROR, errorResponse: "Something Went Wrong");
    }
  }
}
