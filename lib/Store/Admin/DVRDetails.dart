// ignore_for_file: prefer_is_empty, file_names

import 'package:velocity_x/velocity_x.dart';

import '../../Bloc/DVRDetailsBloc.dart';
import '../store.dart';

class SearchMutation extends VxMutation<MyStore> {
  final String query;

  SearchMutation(this.query);
  @override
  perform() {
    if (query.length >= 1) {
      store?.lstDVR = DVRDetailsBloc.lst
          .where((element) =>
              element.ip.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      store?.lstDVR = DVRDetailsBloc.lst;
    }
  }
}
