import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Student/student_courses.dart';
import 'package:live_streaming/Screens/onboding/components/sign_in_form.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Student/courses_view_model.dart';
import 'package:live_streaming/view_models/signin_view_model.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:provider/provider.dart';
import 'components/course_card.dart';
import 'components/secondary_course_card.dart';
import 'components/text.dart';
import 'course.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(slivers: [
        stdteacherappbar(context),
        SliverToBoxAdapter(
          child: ui(context),
        )
      ]),
    );
  }

  Widget ui(BuildContext context) {
    final providr = context.watch<SignInViewModel>();
    int index = -1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20, top: 16),
          child: student_text(context, "Courses", 30),
        ),
        ChangeNotifierProvider(
            create: (context) =>
                CourseViewModel(providr.user.userID.toString()),
            child: Consumer<CourseViewModel>(
                builder: ((context, courseProvider, child) {
              if (courseProvider.isloading) {
                return apploading(context);
              } else if (courseProvider.userError != null) {
                return ErrorMessage(
                    courseProvider.userError!.message.toString());
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: courseProvider.lstcourses.map((course) {
                    index++;
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CourseCard(
                        title: course.courseName,
                        iconSrc: course.image,
                        instructor: course.teacherName,
                        color: index % 3 == 0
                            ? const Color(0xFF7553F6)
                            : index % 3 == 1
                                ? const Color(0xFF80A4FF)
                                : const Color(0xFF9CC5FF),
                      ),
                    );
                  }).toList(),
                ),
              );
            }))),
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
