// ignore_for_file: constant_identifier_names, file_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:live_streaming/Controller/dvr.dart';
import 'package:live_streaming/Model/Admin/DVR/dvr.dart';
import 'package:live_streaming/Model/Admin/ip.dart';
import 'package:provider/provider.dart';

class DVRDetailsBloc {
  static List<DVR> lst = [];
  DVRController? dvrcontroller;
  DVR? c;
  int? index;

  Future<List<DVR>> getData(BuildContext context) async {
    try {
      await http
          .get(Uri.parse('${NetworkIP.base_url}api/dvr-details'))
          .then((response) {
        if (response.statusCode == 200) {
          lst = [];
          var data = json.decode(response.body);
          for (var i in data["data"]) {
            lst.add(DVR.fromJson(i));
          }
          Provider.of<DVRController>(context, listen: false).dvrlist(lst);
        }
      });

      return lst;
    } catch (e) {
      return lst;
    }
  }
}
