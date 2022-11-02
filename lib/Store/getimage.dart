// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:live_streaming/Store/store.dart';
import 'package:velocity_x/velocity_x.dart';

class getimageMutation extends VxMutation<MyStore> {
  File image;
  getimageMutation({required this.image});
  @override
  perform() {
    store!.image = image;
  }
}
