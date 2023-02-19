import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'components/course_card.dart';
import 'components/secondary_course_card.dart';
import 'components/text.dart';
import 'course.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(slivers: [
        std_teacher_appbar(context),
        SliverToBoxAdapter(
          child: ui(context),
        )
      ]),
    );
  }

  Widget ui(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20, top: 16),
          child: student_text(context, "Courses", 30),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: courses
                .map(
                  (course) => Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CourseCard(
                      title: course.title,
                      iconSrc: course.iconSrc,
                      color: course.color,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Recent",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        ...recentCourses
            .map((course) => Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: SecondaryCourseCard(
                    title: course.title,
                    iconsSrc: course.iconSrc,
                    colorl: course.color,
                  ),
                ))
            .toList(),
      ],
    );
  }
}
