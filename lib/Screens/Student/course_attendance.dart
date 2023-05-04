import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Student/courses_view_model.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:live_streaming/widget/teachertopbar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class CourseAttendanceScreen extends StatelessWidget {
  const CourseAttendanceScreen({super.key, required this.provider});
  final CourseViewModel provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          stdteacherappbar(context, isback: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Teachertopcard(
                    context,
                    provider.lstcourses[provider.selectedIndex].image == ""
                        ? ""
                        : "${getuserimage}Teacher/${provider.lstcourses[provider.selectedIndex].image}",
                    provider.lstcourses[provider.selectedIndex].teacherName,
                    false,
                    () {}),
                ChangeNotifierProvider<CourseViewModel>.value(
                  value: provider,
                  child: Consumer<CourseViewModel>(
                      builder: ((context, provider, child) =>
                          _ui(context, provider))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _ui(BuildContext context, CourseViewModel courseProvider) {
    if (courseProvider.isloading) {
      return apploading(context);
    } else if (courseProvider.userError != null) {
      return ErrorMessage(courseProvider.userError!.message.toString());
    }
    return courseProvider.lstCourseAttendance.isEmpty
        ? Center(child: large_text("No Class Held"))
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SingleChildScrollView(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: courseProvider.lstCourseAttendance.length,
                    itemBuilder: (context, index) => Container(
                          color:
                              courseProvider.lstCourseAttendance[index].status
                                  ? Colors.transparent
                                  : Colors.redAccent,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    text_medium(courseProvider
                                        .lstCourseAttendance[index].date),
                                    text_medium(courseProvider
                                            .lstCourseAttendance[index].status
                                        ? "P"
                                        : "A")
                                  ],
                                ),
                              ),
                              const Divider()
                            ],
                          ),
                        ))),
          );
  }
}
