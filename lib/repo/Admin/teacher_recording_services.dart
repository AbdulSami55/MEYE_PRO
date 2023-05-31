import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/recordings.dart';
import '../../utilities/constants.dart';
import '../api_status.dart';

class TeacherRecordingServies {
  static Future<Object> getRecordings(String teacherName) async {
    try {
      var response =
          await http.get(Uri.parse("$getteacherrecordings$teacherName"));
      if (response.statusCode == 200) {
        return Success(response: recordingsFromJson(response.body));
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

  static Future<Object> getAllRecordings() async {
    try {
      var response = await http.get(Uri.parse(getallrecordingsurl));
      if (response.statusCode == 200) {
        return Success(response: recordingsFromJson(response.body));
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
