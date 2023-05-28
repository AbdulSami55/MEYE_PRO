import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/swapping.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/utilities/constants.dart';

class SwappingServies {
  static Future<Object> getData(
      String day, String startTime, String endTime, int timeTableId) async {
    try {
      var response = await http.get(
          Uri.parse(
              "$getSwappingUserDataurl?day=$day&startTime=$startTime&endTime=$endTime&timeTableId=$timeTableId"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data == 'Class Already Swapped') {
          return Success(response: data);
        }
        return Success(response: swappingUserFromJson(response.body));
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

  static Future<Object> insertSwapping(Swapping swapping) async {
    try {
      var response = await http.post(Uri.parse(addswappingurl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(swapping.toJson()));
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
