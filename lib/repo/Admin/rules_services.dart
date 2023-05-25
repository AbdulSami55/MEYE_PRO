import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/rules_timeTable.dart';
import '../../utilities/constants.dart';
import '../api_status.dart';

class RulesServices {
  static Future<Object> addRules(
      List<Map<String, dynamic>> lst, String teacherName) async {
    try {
      var response = await http.post(Uri.parse('$addRulesurl/$teacherName'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(lst));
      if (response.statusCode == 200) {
        return Success(response: json.decode(response.body));
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

  Future<Object> getRulesTimeTable(String teacherName) async {
    try {
      var response =
          await http.get(Uri.parse("$getteacherrulestimetableurl$teacherName"));
      if (response.statusCode == 200) {
        return Success(response: RulesData.fromJson(jsonDecode(response.body)));
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
