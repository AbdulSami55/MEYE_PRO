import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/utilities/constants.dart';

import '../../Model/Admin/timetable.dart';
import '../api_status.dart';

class TimeTableServices {
  Future<Object> gettimetable(String teacherName) async {
    try {
      var response =
          await http.get(Uri.parse("$getteachertimetableurl$teacherName"));
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
}
