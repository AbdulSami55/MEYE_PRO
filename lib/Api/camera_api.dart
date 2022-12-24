import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/Camera/camera.dart';
import 'package:live_streaming/Model/Admin/ip.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:velocity_x/velocity_x.dart';

class CameraApi {
  Future<String> post(Camera c) async {
    var response =
        await http.post(Uri.parse('${NetworkIP.base_url}api/add-camera'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: json.encode(c.toJson()));

    if (response.statusCode == 200) {
      var val = json.decode(response.body);
      return val["data"];
    } else {
      return "error";
    }
  }

  Future put(Camera c) async {
    try {
      var response = await http.put(
          Uri.parse('${NetworkIP.base_url}api/update-camera-details'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(c.toJson()));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        c = Camera.fromJson(data["data"]);
        return c;
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future delete(Camera c) async {
    try {
      var response = await http.delete(
          Uri.parse('${NetworkIP.base_url}api/delete-camera-details'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(c.toJson()));
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

  // Future getChannel(String ip) async {
  //   var response = await http.post(
  //       Uri.parse('${NetworkIP.base_url}api/get-camera-channel'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: json.encode({"ip": ip}));

  //   if (response.statusCode == 200) {
  //     var val = json.decode(response.body);
  //     return val["channel"];
  //   } else {
  //     return "error";
  //   }
  // }
}
