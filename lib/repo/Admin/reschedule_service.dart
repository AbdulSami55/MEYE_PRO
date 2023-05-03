import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/schedule.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import '../../utilities/constants.dart';
import '../api_status.dart';

class RescheduleServies {
  static Future<Object> post(Schedule s) async {
    try {
      var response = await http.post(Uri.parse(addreschedule),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(s.toJson()));
      if (response.statusCode == 200) {
        return Success(response: json.decode(response.body)["data"]);
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

  static Future<Object> getTimetable(String startdate, String enddate) async {
    try {
      var response = await http.get(Uri.parse(
          "$getTimeTableByDateurl?startdate=$startdate&enddate=$enddate"));
      if (response.statusCode == 200) {
        return Success(response: timeTableFromJson(response.body));
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

  static Future<Object> checkTeacherRescheduleClass(String teacherName) async {
    try {
      var response = await http.get(Uri.parse(
          "$getcheckTeacherRescheduleClassurl?teacherName=$teacherName"));
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
