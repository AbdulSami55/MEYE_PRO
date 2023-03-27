import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Teacher/attendance.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/utilities/constants.dart';

class AttendanceServices {
  static Future<Object> markAttendance(File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(markAttendanceurl),
      );
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        var res = await http.Response.fromStream(response);
        return Success(response: attendanceFromJson(res.body));
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
