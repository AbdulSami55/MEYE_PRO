import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/demo.dart';
import 'package:live_streaming/repo/api_status.dart';
import '../../utilities/constants.dart';

class DemoServies {
  static Future<Object> getAllDemoVideo() async {
    try {
      var response = await http
          .get(Uri.parse(getAllDemoVideourl), headers: <String, String>{
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        return Success(response: demoFromJson(response.body));
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

  static Future<Object> getDemoVideoDetails(String fileName) async {
    try {
      var response = await http.get(
          Uri.parse("$getDemoVideDetailsurl$fileName"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        return Success(response: demoDetailsFromJson(response.body));
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
