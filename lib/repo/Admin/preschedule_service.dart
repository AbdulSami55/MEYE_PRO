import 'dart:convert';
import 'dart:io';

import 'package:live_streaming/Model/Admin/preschedule.dart';
import 'package:http/http.dart' as http;
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/utilities/constants.dart';

class PreScheduleServies {
  static Future<Object> post(PreSchedule s) async {
    try {
      var response = await http.post(Uri.parse(addpreschedule),
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
}
