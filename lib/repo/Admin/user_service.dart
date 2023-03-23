// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/student.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import '../../utilities/constants.dart';
import '../api_status.dart';

class UserServies {
  static Future<Object> SignIn(String userId, String password) async {
    try {
      var response = await http
          .get(Uri.parse("$getsigninurl?userId=$userId&password=$password"));
      if (response.statusCode == 200) {
        return Success(response: response.body);
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

  static Future<Object> post(User u, File file) async {
    try {
      if (u.role == 'Teacher') {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "$adduserurl?id=0&userID=${u.userID}&name=${u.name}&image=0&password=${u.password}&role=${u.role}"),
        );
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
        var response = await request.send();
        if (response.statusCode == 200) {
          var responsed = await http.Response.fromStream(response);
          final responseData = jsonDecode(responsed.body);
          return Success(response: responseData);
        }
      } else {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "$addstudenturl?aridNo=${u.userID}&name=${u.name}&image=0&password=${u.password}"),
        );
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
        var response = await request.send();
        if (response.statusCode == 200) {
          var responsed = await http.Response.fromStream(response);
          final responseData = jsonDecode(responsed.body);
          return Success(response: responseData);
        }
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

  static Future<Object> getUser() async {
    try {
      var response = await http.get(Uri.parse(getuserurl));
      if (response.statusCode == 200) {
        return Success(response: userFromJson(response.body));
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

  static Future<Object> getStudent() async {
    try {
      var response = await http.get(Uri.parse(getstudenturl));
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
