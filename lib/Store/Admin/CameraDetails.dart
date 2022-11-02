// ignore_for_file: prefer_is_empty

import 'package:velocity_x/velocity_x.dart';

import '../../Bloc/CameraDetailsBloc.dart';
import '../store.dart';

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
