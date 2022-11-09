// ignore_for_file: constant_identifier_names, file_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Model/Admin/ip.dart';
import 'package:live_streaming/Model/Teacher/teacher.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:velocity_x/velocity_x.dart';

enum TeacherDetailsAction { Fetch }

class TeacherDetailsBloc {
  static List<TeacherData> lst = [];
  TeacherData? c;
  int? index;
  final _stateTeacherDetailsController =
      StreamController<List<TeacherData>>.broadcast();
  StreamSink<List<TeacherData>> get _sinkTeacherDetails =>
      _stateTeacherDetailsController.sink;
  Stream<List<TeacherData>> get streamTeacherDetails =>
      _stateTeacherDetailsController.stream;

  final _eventTeacherDetailsController =
      StreamController<TeacherDetailsAction>.broadcast();
  StreamSink<TeacherDetailsAction> get eventsinkTeacherDetails =>
      _eventTeacherDetailsController.sink;
  Stream<TeacherDetailsAction> get _eventstreamTeacherDetails =>
      _eventTeacherDetailsController.stream;

  TeacherDetailsBloc() {
    _eventstreamTeacherDetails.listen((event) async {
      if (event == TeacherDetailsAction.Fetch) {
        try {
          (VxState.store as MyStore).lstteacher = [];
          var data = await getData();
          _sinkTeacherDetails.add(data);
        } catch (e) {
          _sinkTeacherDetails.addError("Something Went Wrong..");
        }
      }
    });
  }

  Future<List<TeacherData>> getData() async {
    lst = [];
    (VxState.store as MyStore).lstteacher = [];
    try {
      var response =
          await http.get(Uri.parse('${NetworkIP.base_url}api/teacher-details'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        lst = [];
        for (int i = 0; i < data['id'].length; i++) {
          TeacherData t = TeacherData(
              tID: data['id'][i],
              tNAME: data['name'][i],
              tIMAGE: data['image'][i],
              tPASS: data['password'][i]);
          lst.add(t);
        }
      }
      (VxState.store as MyStore).lstteacher = lst;
      return lst;
    } catch (e) {
      return lst;
    }
  }
}
