import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/ip.dart';
import 'package:live_streaming/Model/Admin/schedule.dart';

class TeacherScheduleApi {
  Future<String> post(TeacherSchedule teacherschedule) async {
    var response = await http.post(
        Uri.parse('${NetworkIP.base_url}api/add-teacherschedule'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "id": teacherschedule.tid,
          "disp": teacherschedule.displine,
          "sem": teacherschedule.sem,
          "sec": teacherschedule.sec,
          "starttime": teacherschedule.starttime,
          "endtime": teacherschedule.endtime,
          "sr": teacherschedule.fmin ? '1' : '0',
          "er": teacherschedule.lmin ? '1' : '0',
          "ar": teacherschedule.full ? '1' : '0',
          "coursename": teacherschedule.coursename,
          "day": teacherschedule.day,
          "room": teacherschedule.room
        }));

    if (response.statusCode == 200) {
      var val = json.decode(response.body);
      return val["data"];
    } else {
      return "error";
    }
  }

  Future put(TeacherSchedule teacherschedule,
      TeacherSchedule teacherscheduleold) async {
    try {
      var response = await http.put(
          Uri.parse('${NetworkIP.base_url}api/update-teacherschedule-details'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(
            [
              {
                "id": teacherschedule.tid,
                "disp": teacherschedule.displine,
                "sem": teacherschedule.sem,
                "sec": teacherschedule.sec,
                "starttime": teacherschedule.starttime,
                "endtime": teacherschedule.endtime,
                "coursename": teacherschedule.coursename,
                "sr": teacherschedule.starttime,
                "er": teacherschedule.endtime,
                "ar": teacherschedule.full,
                "day": teacherschedule.day,
                "room": teacherschedule.room
              },
              {
                "id": teacherscheduleold.tid,
                "disp": teacherscheduleold.displine,
                "sem": teacherscheduleold.sem,
                "sec": teacherscheduleold.sec,
                "starttime": teacherscheduleold.starttime,
                "endtime": teacherscheduleold.endtime,
                "coursename": teacherscheduleold.coursename,
                "sr": teacherscheduleold.starttime,
                "er": teacherscheduleold.endtime,
                "ar": teacherscheduleold.full,
                "day": teacherscheduleold.day,
                "room": teacherschedule.room
              }
            ],
          ));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        teacherschedule = TeacherSchedule.fromjson(data);
        return teacherschedule;
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future delete(TeacherSchedule teacherschedule) async {
    try {
      var response = await http.delete(
          Uri.parse('${NetworkIP.base_url}api/delete-teacherschedule-details'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "id": teacherschedule.tid,
            "disp": teacherschedule.displine,
            "sem": teacherschedule.sem,
            "sec": teacherschedule.sec,
            "starttime": teacherschedule.starttime,
            "endtime": teacherschedule.endtime,
            "coursename": teacherschedule.coursename,
            "sr": teacherschedule.starttime,
            "er": teacherschedule.endtime,
            "ar": teacherschedule.full,
            "day": teacherschedule.day,
            "room": teacherschedule.room
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
