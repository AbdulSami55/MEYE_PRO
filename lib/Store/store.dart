// ignore_for_file: prefer_is_empty

import 'package:live_streaming/Bloc/CameraDetailsBloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Model/Admin/Camera/Camera.dart';

class MyStore extends VxStore {
  List<Camera>? lstcamera = [];

  MyStore() {}
}

class SearchMutation extends VxMutation<MyStore> {
  final String query;

  SearchMutation(this.query);
  @override
  perform() {
    if (query.length >= 1) {
      store?.lstcamera = CameraDetailsBloc.lst
          .where((element) =>
              element.lt.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      store?.lstcamera = CameraDetailsBloc.lst;
    }
  }
}
