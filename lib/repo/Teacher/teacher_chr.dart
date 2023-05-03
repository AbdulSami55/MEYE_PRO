import 'dart:io';
import 'package:http/http.dart' as http;
import '../../Model/Teacher/teacher_chr.dart';
import '../../utilities/constants.dart';
import '../api_status.dart';

class TeacherCHRServies {
  static Future<Object> getTeacherCHR(String teacherName) async {
    try {
      var response = await http.get(
          Uri.parse("$getTeacherCHRurl?teacherName=$teacherName"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        return Success(response: teacherChrFromMap(response.body));
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

  static Future<Object> getAllTeacherCHR() async {
    try {
      var response = await http
          .get(Uri.parse(getAllTeacherCHRurl), headers: <String, String>{
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        return Success(response: teacherChrFromMap(response.body));
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
