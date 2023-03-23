import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/Profile/section_offer_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/textcomponents/small_text.dart';
import 'package:provider/provider.dart';

class AssignCourse extends StatelessWidget {
  const AssignCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar("Assign Course"),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
              create: (context) => SectionOfferViewModel(),
              child: Consumer<SectionOfferViewModel>(
                  builder: (context, provider, child) =>
                      _ui(context, provider)),
            ),
          )
        ],
      ),
    );
  }

  Widget _ui(BuildContext context, SectionOfferViewModel provider) {
    if (provider.isloading) {
      return apploading();
    }
    if (provider.userError != null) {
      return ErrorMessage(provider.userError!.message.toString());
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
        child: textSmall("Select Discipline"),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
          color: containerColor,
          child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(
                  Icons.type_specimen,
                  color: primaryColor,
                ),
              ),
              isExpanded: true,
              value: provider.selectedValue,
              items: provider.lstCourseDropdown,
              onChanged: (value) {
                provider.setSelectedValue(value!);
              }),
        ),
      ),
      coursesListView(provider),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: mybutton(() {
            context.pushNamed(routesStudentCourseOffered, params: {
              'sectionOfferId': jsonEncode(provider.lstCourses
                  .where((element) => element.isSelected)
                  .toList()
                  .map((e) => e.id)
                  .toList()),
              'lstcourse': jsonEncode(provider.lstCourses
                  .where((element) => element.isSelected)
                  .toList()
                  .map((e) => e.courseName)
                  .toList())
            });
          }, "Next", Icons.navigate_next_outlined))
    ]);
  }

  ListView coursesListView(SectionOfferViewModel provider) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: provider.lstCourses.length,
        itemBuilder: (context, index) => ListTile(
            tileColor: provider.lstCourses[index].isSelected
                ? Colors.white
                : Colors.transparent,
            title: text_medium(provider.lstCourses[index].courseName),
            trailing: Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  provider.changeCourse(index);
                },
                child: context
                        .watch<SectionOfferViewModel>()
                        .lstCourses[index]
                        .isSelected
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(99.0)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 14),
                            child:
                                text_medium("X", color: Colors.red, font: 20)),
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
            })));
  }
}
