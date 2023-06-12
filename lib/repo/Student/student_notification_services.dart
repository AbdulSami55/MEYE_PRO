import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Student/student_notification.dart';
import '../../utilities/constants.dart';
import '../api_status.dart';

class StudentNotificationServies {
  static Future<Object> getStudentNotification(String aridNumber) async {
    try {
      var response = await http.get(
          Uri.parse("$getStudentNotificationurl?aridNumber=$aridNumber"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        return Success(response: studentNotificationFromMap(response.body));
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
