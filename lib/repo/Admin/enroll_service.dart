import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/enroll.dart';
import '../../utilities/constants.dart';
import '../api_status.dart';

class EnrollServies {
  static Future<Object> enrollStudent(List<Enroll> lstenroll) async {
    try {
      var response = await http.post(Uri.parse(enrollStudenturl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(lstenroll.map((e) => e.toJson()).toList()));
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
