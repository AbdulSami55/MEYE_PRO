// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';

class TeacherCHRDetailsScreen extends StatelessWidget {
  TeacherCHRDetailsScreen({super.key, required this.provider});
  TeacherCHRViewModel provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(slivers: [
        stdteacherappbar(context, isteacher: true, isback: true),
      ]),
    );
  }
}
