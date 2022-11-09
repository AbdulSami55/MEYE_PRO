import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/ip.dart';

import '../Model/Admin/DVR/DVR.dart';

class DVRApi {
  Future<String> post(DVR c) async {
    var response = await http.post(
        Uri.parse('${NetworkIP.base_url}api/add-dvr'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "ip": c.ip,
          "channel": c.channel,
          "password": c.password,
          "host": c.host
        }));

    if (response.statusCode == 200) {
      var val = json.decode(response.body);
      return val["data"];
    } else {
      return "error";
    }
  }

  Future put(DVR c) async {
    try {
      var response = await http.put(
          Uri.parse('${NetworkIP.base_url}api/update-dvr-details'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "ip": c.ip,
            "channel": c.channel,
            "password": c.password,
            "host": c.host
          }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        c = DVR.fromjson(data);
        return c;
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future delete(DVR c) async {
    try {
      var response = await http.delete(
          Uri.parse('${NetworkIP.base_url}api/delete-dvr-details'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "ip": c.ip,
            "channel": c.channel,
            "password": c.password,
            "host": c.host
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
