// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_streaming/Model/Admin/swapping.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/swapping_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/search_bar.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/textcomponents/small_text.dart';
import 'package:provider/provider.dart';

class SwappingTeacherDetails extends StatelessWidget {
  SwappingTeacherDetails(
      {super.key,
      required this.day,
      required this.endTime,
      required this.startTime,
      required this.id});
  String day, startTime, endTime;
  int id;
  @override
  Widget build(BuildContext context) {
    SwappingViewModel swappingViewModel = context.watch<SwappingViewModel>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        appbar("Swapping Users", bgColor: backgroundColor),
        searchBar(isTeacher: true, isSwappingTeacherDetails: true),
        SliverToBoxAdapter(
          child: _ui(swappingViewModel, context),
        ),
      ]),
    );
  }

  _ui(SwappingViewModel swappingViewModel, BuildContext context) {
    if (swappingViewModel.loading) {
      return apploading(context);
    }
    if (swappingViewModel.userError != null) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.36,
          ),
          ErrorMessage(swappingViewModel.userError!.message.toString()),
        ],
      );
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: swappingViewModel.lstSwappingUserSlot.length,
        itemBuilder: (context, index) => id ==
                swappingViewModel.lstSwappingUserSlot[index].timeTableId
            ? const Padding(padding: EdgeInsets.zero)
            : Column(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Swap Class"),
                          content: const Text("Are You Sure?"),
                          actions: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("No"),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  showLoaderDialog(context, 'Swapping');
                                  String date =
                                      DateTime.now().toString().split(' ')[0];
                                  DateTime startDate = DateTime(
                                      int.parse(date.split('-')[0]),
                                      int.parse(date.split('-')[1]),
                                      int.parse(date.split('-')[2]));
                                  List<DateTime> nextDates = [];

                                  for (int i = 0; i <= 7; i++) {
                                    nextDates
                                        .add(startDate.add(Duration(days: i)));
                                  }
                                  for (DateTime dateTime in nextDates) {
                                    if (DateFormat('EEEE, MMMM dd, yyyy')
                                            .format(dateTime)
                                            .toString()
                                            .split(',')[0] ==
                                        day) {
                                      Swapping swapping = Swapping(
                                          id: 0,
                                          timeTableIdFrom: id,
                                          timeTableIdTo: swappingViewModel
                                              .lstSwappingUserSlot[index]
                                              .timeTableId,
                                          starttime: startTime,
                                          endtime: endTime,
                                          day: day,
                                          date:
                                              dateTime.toString().split(' ')[0],
                                          status: false);
                                      var data = await swappingViewModel
                                          .insertdata(swapping);
                                      if (data == 'okay') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snack_bar(
                                                "Class Swapped", true));
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snack_bar(
                                                "Something Went Wrong", false));
                                      }
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      );
                    },
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textSmall(swappingViewModel
                              .lstSwappingUserSlot[index].venue
                              .toString()),
                          textSmall(swappingViewModel
                              .lstSwappingUserSlot[index].discipline
                              .toString()),
                        ],
                      ),
                      leading: swappingViewModel
                                  .lstSwappingUserSlot[index].image ==
                              null
                          ? const CircleAvatar(
                              radius: 33,
                              backgroundImage: AssetImage(
                                  "assets/avaters/Avatar Default.jpg"),
                            )
                          : CircleAvatar(
                              radius: 33,
                              backgroundImage: NetworkImage(
                                  "$getuserimage${swappingViewModel.lstSwappingUserSlot[index].role}/${swappingViewModel.lstSwappingUserSlot[index].image}")),
                      title: text_medium(swappingViewModel
                          .lstSwappingUserSlot[index].name
                          .toString()),
                    ),
                  ),
                  const Divider()
                ],
              ));
  }
}
