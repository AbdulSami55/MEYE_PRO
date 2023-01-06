import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/user.dart';
import '../../utilities/constants.dart';
import '../api_status.dart';

class UserServies {
  static Future<Object> post(User u, File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "$adduser?id=0&uid=${u.uid}&name=${u.name}&image=0&password=${u.password}&role=${u.role}"),
      );
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        var responsed = await http.Response.fromStream(response);
        final responseData = jsonDecode(responsed.body);
        return Success(response: responseData["data"]);
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
      var response = await http.get(Uri.parse(getuser));
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

  // Future put(Camera c) async {
  //   try {
  //     var response =
  //         await http.put(Uri.parse('$baseUrl/api/update-camera-details'),
  //             headers: <String, String>{
  //               'Content-Type': 'application/json',
  //             },
  //             body: json.encode(c.toJson()));
  //     if (response.statusCode == 200) {
  //       return Success(response: json.decode(response.body)["data"]);
  //     }
  //     return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Response");
  //   } on HttpException {
  //     return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
  //   } on FormatException {
  //     return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
  //   } catch (e) {
  //     return Failure(
  //         code: UNKNOWN_ERROR, errorResponse: "Something Went Wrong");
  //   }
  // }

  // Future delete(Camera c) async {
  //   try {
  //     var response =
  //         await http.delete(Uri.parse('$baseUrl/api/delete-camera-details'),
  //             headers: <String, String>{
  //               'Content-Type': 'application/json; charset=UTF-8',
  //             },
  //             body: json.encode(c.toJson()));
  //     if (response.statusCode == 200) {
  //       return Success(response: json.decode(response.body)["data"]);
  //     }
  //     return Failure(code: INVALID_RESPONSE, errorResponse: "Invalid Response");
  //   } on HttpException {
  //     return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
  //   } on FormatException {
  //     return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
  //   } catch (e) {
  //     return Failure(
  //         code: UNKNOWN_ERROR, errorResponse: "Something Went Wrong");
  //   }
  // }
}
