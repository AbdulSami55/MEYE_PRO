// ignore_for_file: prefer_is_empty, file_names

import 'package:live_streaming/Bloc/teacherDetailsBloc.dart';
import 'package:live_streaming/Model/Admin/schedule.dart';
import 'package:velocity_x/velocity_x.dart';
import '../store.dart';

class TeacherSearchMutation extends VxMutation<MyStore> {
  final String query;

  TeacherSearchMutation(this.query);
  @override
  perform() {
    if (query.length >= 1) {
      store?.lstteacher = TeacherDetailsBloc.lst
          .where((element) =>
              element.tNAME!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      store?.lstteacher = TeacherDetailsBloc.lst;
    }
  }
}

class TeacherScheduleMutation extends VxMutation<MyStore> {
  final TeacherSchedule teacherSchedule;

  TeacherScheduleMutation(this.teacherSchedule);
  @override
  perform() {
    store!.teacherSchedule = teacherSchedule;
  }
}
