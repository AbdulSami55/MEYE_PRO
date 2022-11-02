import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/ip.dart';
import 'package:live_streaming/Model/Teacher/Teacher.dart';

class TeacherApi {
  Future<String> post(TeacherData t) async {
    var response = await http.post(
        Uri.parse('${NetworkIP.base_url}api/add-teacher'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "id": t.tID,
          "name": t.tNAME,
          "password": t.tPASS,
          "image": t.tIMAGE
        }));

    if (response.statusCode == 200) {
      var val = json.decode(response.body);
      return val["data"];
    } else {
      return "error";
    }
  }

  Future put(TeacherData t) async {
    try {
      var response = await http.put(
          Uri.parse('${NetworkIP.base_url}api/update-teacher-details'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "id": t.tID,
            "name": t.tNAME,
            "password": t.tPASS,
            "image": t.tIMAGE
          }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        t = TeacherData.fromjson(data);
        return t;
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future delete(TeacherData t) async {
    try {
      var response = await http.delete(
          Uri.parse('${NetworkIP.base_url}api/delete-teacher-details'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "id": t.tID,
            "name": t.tNAME,
            "password": t.tPASS,
            "image": t.tIMAGE
          }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String res = data["data"].toString();
        return res;
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return "Something went wrong";
    }
  }
}
