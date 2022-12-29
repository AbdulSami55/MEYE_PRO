import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/venue.dart';
import '../Model/Admin/camera.dart';
import '../utilities/constants.dart';
import 'api_status.dart';

class VenueServies {
  static Future<Object> post(Venue v) async {
    try {
      var response = await http.post(Uri.parse(addcameraurl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(v.toJson()));
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

  Future put(Camera c) async {
    try {
      var response =
          await http.put(Uri.parse('$baseUrl/api/update-camera-details'),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: json.encode(c.toJson()));
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

  Future delete(Camera c) async {
    try {
      var response =
          await http.delete(Uri.parse('$baseUrl/api/delete-camera-details'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode(c.toJson()));
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

  static Future<Object> getVenue() async {
    try {
      var response = await http.get(Uri.parse(getvenue));
      if (response.statusCode == 200) {
        return Success(response: venueFromJson(response.body));
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
