// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/repo/Admin/enroll_service.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/User/student_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/search_bar.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class StudentCourseOffered extends StatelessWidget {
  StudentCourseOffered({super.key, this.lstcourse, this.sectionOfferId});
  String? lstcourse;
  String? sectionOfferId;

  List<String> getCourse(List lst) {
    return lst.map((e) => e.toString()).toList();
  }

  List<int> getSectionOfferId(List lst) {
    return lst.map((e) => int.parse(e.toString())).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> lstCourse = getCourse(jsonDecode(lstcourse!));
    List<int> tempSectionOfferId =
        getSectionOfferId(jsonDecode(sectionOfferId!));
    StudentViewModel studentViewModel = StudentViewModel();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: RefreshIndicator(
        onRefresh: () => StudentViewModel().getData(lstCourse),
        child: CustomScrollView(
          slivers: [
            appbar("Student  Details"),
            searchBar(isTeacher: false),
            SliverToBoxAdapter(
              child: ChangeNotifierProvider(
                create: (context) => StudentViewModel(lstcourse: lstCourse),
                child: Consumer<StudentViewModel>(
                    builder: (context, provider, child) {
                  studentViewModel = provider;
                  return _ui(context, provider, tempSectionOfferId);
                }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ChangeNotifierProvider.value(
        value: studentViewModel,
        child: FloatingActionButton(
          onPressed: () async {
            showLoaderDialog(context, "Loading...");

            var response =
                await EnrollServies.enrollStudent(studentViewModel.lstEnroll);
            if (response is Success) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(snack_bar(response.response.toString(), true));
              Navigator.pop(context);
              Navigator.pop(context);
              context.pushReplacement(routesAssignCourse);
            } else if (response is Failure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  snack_bar(response.errorResponse.toString(), false));
            }
          },
          child: const Icon(Icons.assignment_turned_in_rounded),
        ),
      ),
    );
  }

  Widget _ui(BuildContext context, StudentViewModel provider,
      List<int> tempSectionOfferId) {
    if (provider.isloading) {
      return apploading();
    }
    if (provider.userError != null) {
      return ErrorMessage(provider.userError!.message.toString());
    } else if (provider.lstStudent.isEmpty) {
      return ErrorMessage("No Data");
    }
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: provider.lstStudent.length,
            itemBuilder: (context, index) => Container(
                  color: provider.lstStudent[index].isSelected!
                      ? containerColor
                      : Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: studentView(provider, index, tempSectionOfferId),
                      ),
                      const Divider(
                        height: 2,
                      )
                    ],
                  ),
                )),
      ],
    );
  }

  ListTile studentView(
      StudentViewModel provider, int index, List<int> tempSectionOfferId) {
    return ListTile(
      leading: CircleAvatar(
          radius: 33,
          backgroundImage: NetworkImage(
              "$getstudentimage${provider.lstStudent[index].image}")),
      title: text_medium(provider.lstStudent[index].name.toString()),
      trailing: Builder(builder: (context) {
        return InkWell(
          onTap: () {
            provider.changeStudent(index, tempSectionOfferId);
          },
          child: context.watch<StudentViewModel>().lstStudent[index].isSelected!
              ? Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(99.0)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 14.0),
                      child: text_medium("X", color: Colors.red, font: 20)),
                )
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(99.0)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.done,
                      color: primaryColor,
                    ),
                  ),
                ),
        );
      }),
    );
  }
}
