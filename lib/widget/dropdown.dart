// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:live_streaming/Store/Admin/setscheduleSearch.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:velocity_x/velocity_x.dart';

class MyDropDown extends StatelessWidget {
  MyDropDown(
      {super.key,
      this.listen,
      required this.selectedvalue,
      required this.items,
      this.textvalue});

  int? listen;
  String selectedvalue;
  String? textvalue;
  List<DropdownMenuItem<String>> items;
  @override
  Widget build(BuildContext context) {
    final store = (VxState.store as MyStore);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(textvalue == null ? '' : textvalue!).pOnly(left: 10),
            Container(
              width: 100,
              child: DropdownButton(
                isExpanded: true,
                value: selectedvalue,
                items: items,
                onChanged: (Object? value) {
                  if (listen == 0) {
                    store.teacherSchedule!.displine = value.toString();
                    TeacherScheduleMutation(store.teacherSchedule!);
                  } else if (listen == 1) {
                    store.teacherSchedule!.sem = value.toString();
                    TeacherScheduleMutation(store.teacherSchedule!);
                  } else if (listen == 2) {
                    store.teacherSchedule!.sec = value.toString();
                    TeacherScheduleMutation(store.teacherSchedule!);
                  } else if (listen == 3) {
                    store.teacherSchedule!.day = value.toString();
                    TeacherScheduleMutation(store.teacherSchedule!);
                  } else if (listen == 4) {
                    store.teacherSchedule!.starttime = value.toString();
                    TeacherScheduleMutation(store.teacherSchedule!);
                  } else if (listen == 5) {
                    store.teacherSchedule!.endtime = value.toString();
                    TeacherScheduleMutation(store.teacherSchedule!);
                  }
                },
              ).pOnly(left: 10),
            )
          ],
        )
      ],
    );
  }
}
