import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/section_offer.dart';
import 'package:live_streaming/Model/Admin/student.dart';
import '../../utilities/constants.dart';
import '../api_status.dart';

class SectionOfferServies {
  static Future<Object> getSectionOfferCourses() async {
    try {
      var response = await http.get(Uri.parse(getSectionOfferCoursesurl));
      if (response.statusCode == 200) {
        return Success(response: sectionOfferFromJson(response.body));
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

  static Future<Object> getStudentOfferCourses(List<String> lstcourse) async {
    try {
      var response = await http.post(Uri.parse(getStudentOfferedCourseurl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(lstcourse));
      if (response.statusCode == 200) {
        return Success(response: studentFromJson(response.body));
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
