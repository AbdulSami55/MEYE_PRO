import 'package:flutter/material.dart';
import 'package:live_streaming/widget/components/appbar.dart';

class AssignCourse extends StatelessWidget {
  const AssignCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [appbar("Assign Course")],
      ),
    );
  }
}
