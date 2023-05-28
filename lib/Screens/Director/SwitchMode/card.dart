// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Screens/Teacher/components/card_text.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';

ListView allTeacher(TeacherCHRViewModel provider, {bool? isShortReport}) {
  return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: provider.lstTempTeacherChr.length,
      itemBuilder: ((context, index) {
        return isShortReport == true
            ? provider.lstTempTeacherChr[index].status == 'Not Held'
                ? mainBody(provider, index, context)
                : const Padding(padding: EdgeInsets.zero)
            : mainBody(provider, index, context);
      }));
}

Widget mainBody(TeacherCHRViewModel provider, int index, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        provider.selectedIndex = index;
        context.push(routesTeacherChrDetails, extra: provider);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 7),
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7)
            ],
            color: containerColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text_medium(provider.lstTempTeacherChr[index].teacherName),
                    provider.lstTempTeacherChr[index].image == ''
                        ? const CircleAvatar(
                            radius: 33,
                            backgroundImage:
                                AssetImage("assets/avaters/Avatar Default.jpg"))
                        : CircleAvatar(
                            radius: 33,
                            backgroundImage: NetworkImage(
                                "${getuserimage}Teacher/${provider.lstTempTeacherChr[index].image}")),
                  ],
                ),
              ),
              cardText('Date: ', provider.lstTempTeacherChr[index].date),
              const SizedBox(
                height: 10,
              ),
              cardText(
                  'Course: ', provider.lstTempTeacherChr[index].courseName),
              const SizedBox(
                height: 10,
              ),
              cardText(
                  'Discipline: ', provider.lstTempTeacherChr[index].discipline),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: text_medium(provider.lstTempTeacherChr[index].status,
                        color:
                            provider.lstTempTeacherChr[index].status == 'Held'
                                ? primaryColor
                                : provider.lstTempTeacherChr[index].status ==
                                        'Not Held'
                                    ? Colors.red
                                    : Colors.redAccent),
                  )
                ],
              ),
              Container(
                height: 4,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: provider.lstTempTeacherChr[index].status == 'Held'
                        ? primaryColor
                        : provider.lstTempTeacherChr[index].status == 'Not Held'
                            ? Colors.red
                            : Colors.redAccent,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(99.0))),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
