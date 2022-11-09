// ignore_for_file: must_be_immutable, sort_child_properties_last, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Api/teacher_schedule_api.dart';
import 'package:live_streaming/Store/Admin/setscheduleSearch.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:live_streaming/widget/button.dart';
import 'package:live_streaming/widget/dropdown.dart';
import 'package:live_streaming/widget/textfield.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../widget/progress_indicator.dart';
import '../../../widget/snack_bar.dart';

class SetSchedule extends StatelessWidget {
  SetSchedule({super.key, required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    final store = (VxState.store as MyStore);
    TextEditingController _coursename = TextEditingController();
    TextEditingController _room = TextEditingController();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          appbar(context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: MemoryImage(base64Decode(
                      (VxState.store as MyStore)
                          .lstteacher![index]
                          .tIMAGE
                          .toString())),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  (VxState.store as MyStore)
                      .lstteacher![index]
                      .tNAME
                      .toString(),
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Dropdown_States(store),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: _coursename,
                  ispassword: false,
                  labelText: 'Enter Course Name',
                  hintText: 'Enter Course Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: _room,
                  ispassword: false,
                  labelText: 'Enter Lab/LT Name',
                  hintText: 'Enter Lab/LT Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () async {
                      if (_coursename.text.isNotEmpty &&
                          _room.text.isNotEmpty) {
                        (VxState.store as MyStore).teacherSchedule!.coursename =
                            _coursename.text;
                        (VxState.store as MyStore).teacherSchedule!.room =
                            _room.text;
                        showLoaderDialog(context, 'Adding');
                        try {
                          TeacherScheduleApi api = TeacherScheduleApi();
                          String res = await api.post(
                              (VxState.store as MyStore).teacherSchedule!);

                          if (res == "okay") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snack_bar(
                                    "Schedule Added Successfully...", true));
                          } else if (res == "sae") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snack_bar("Slot Already Exists...", false));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snack_bar("Something Went Wrong...", false));
                          }
                          Navigator.pop(context);
                        } catch (e) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              snack_bar("Something Went Wrong...", false));
                          Navigator.pop(context);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            snack_bar("Fill All Fields...", false));
                      }
                    },
                    child: MyButton(text: "Submit"))
              ],
            ),
          )
        ],
      ),
    );
  }

  VxBuilder<Object?> Dropdown_States(MyStore store) {
    return VxBuilder(
        mutations: const {TeacherScheduleMutation},
        builder: ((context, stor, status) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyDropDown(
                        listen: 0,
                        selectedvalue: store.teacherSchedule!.displine,
                        items: dispdropdownItems,
                        textvalue: 'Select Discipline',
                      ),
                      MyDropDown(
                        listen: 1,
                        selectedvalue: store.teacherSchedule!.sem,
                        items: semdropdownItems,
                        textvalue: 'Select Semester  ',
                      ),
                      MyDropDown(
                        listen: 2,
                        selectedvalue: store.teacherSchedule!.sec,
                        items: secdropdownItems,
                        textvalue: 'Select Section  ',
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyDropDown(
                        listen: 3,
                        selectedvalue: store.teacherSchedule!.day,
                        items: daydropdownItems,
                        textvalue: 'Select Day           ',
                      ),
                      MyDropDown(
                        listen: 4,
                        selectedvalue: store.teacherSchedule!.starttime,
                        items: starttimedropdownItems,
                        textvalue: 'Select Start Time',
                      ),
                      MyDropDown(
                        listen: 5,
                        selectedvalue: store.teacherSchedule!.endtime,
                        items: endtimedropdownItems,
                        textvalue: 'Select End Time',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Select Video Recording").pOnly(left: 15),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Checkbox(
                      fillColor: const MaterialStatePropertyAll(Colors.orange),
                      value: store.teacherSchedule!.fmin,
                      onChanged: (bool? value) {
                        store.teacherSchedule!.fmin = value!;
                        TeacherScheduleMutation(store.teacherSchedule!);
                      },
                    ),
                    const Text("First 10 Min"),
                    Checkbox(
                      fillColor: const MaterialStatePropertyAll(Colors.orange),
                      value: store.teacherSchedule!.lmin,
                      onChanged: (bool? value) {
                        store.teacherSchedule!.lmin = value!;
                        TeacherScheduleMutation(store.teacherSchedule!);
                      },
                    ),
                    const Text("Last 10 Min"),
                    Checkbox(
                      fillColor: const MaterialStatePropertyAll(Colors.orange),
                      value: store.teacherSchedule!.full,
                      onChanged: (bool? value) {
                        store.teacherSchedule!.full = value!;
                        TeacherScheduleMutation(store.teacherSchedule!);
                      },
                    ),
                    const Text("Full"),
                  ],
                ),
              ],
            )));
  }

  SliverAppBar appbar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey[850],
      automaticallyImplyLeading: false,
      snap: true,
      pinned: true,
      floating: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back)),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Set Schedule",
            style: GoogleFonts.poppins(fontSize: 30),
          ),
        ],
      ),
      elevation: 0,
    );
  }

  List<DropdownMenuItem<String>> get dispdropdownItems {
    List<DropdownMenuItem<String>> dispItems = [
      const DropdownMenuItem(child: Text("BCS"), value: "BCS"),
      const DropdownMenuItem(child: Text("BIT"), value: "BIT"),
      const DropdownMenuItem(child: Text("BSSE"), value: "BSSE"),
      const DropdownMenuItem(child: Text("BAI"), value: "BAI"),
    ];
    return dispItems;
  }

  List<DropdownMenuItem<String>> get semdropdownItems {
    List<DropdownMenuItem<String>> semItems = [
      const DropdownMenuItem(child: Text("1"), value: "1"),
      const DropdownMenuItem(child: Text("2"), value: "2"),
      const DropdownMenuItem(child: Text("3"), value: "3"),
      const DropdownMenuItem(child: Text("4"), value: "4"),
      const DropdownMenuItem(child: Text("5"), value: "5"),
      const DropdownMenuItem(child: Text("6"), value: "6"),
      const DropdownMenuItem(child: Text("7"), value: "7"),
      const DropdownMenuItem(child: Text("8"), value: "8"),
    ];
    return semItems;
  }

  List<DropdownMenuItem<String>> get secdropdownItems {
    List<DropdownMenuItem<String>> secItems = [
      const DropdownMenuItem(child: Text("A"), value: "A"),
      const DropdownMenuItem(child: Text("B"), value: "B"),
      const DropdownMenuItem(child: Text("C"), value: "C"),
      const DropdownMenuItem(child: Text("D"), value: "D"),
      const DropdownMenuItem(child: Text("E"), value: "E"),
      const DropdownMenuItem(child: Text("F"), value: "F"),
      const DropdownMenuItem(child: Text("G"), value: "G"),
      const DropdownMenuItem(child: Text("H"), value: "H"),
    ];
    return secItems;
  }

  List<DropdownMenuItem<String>> get starttimedropdownItems {
    List<DropdownMenuItem<String>> starttimeItems = [
      const DropdownMenuItem(child: Text("8:30"), value: "8:30"),
      const DropdownMenuItem(child: Text("10:00"), value: "10:00"),
      const DropdownMenuItem(child: Text("11:30"), value: "11:30"),
      const DropdownMenuItem(child: Text("1:30"), value: "1:30"),
      const DropdownMenuItem(child: Text("3:00"), value: "3:00"),
    ];
    return starttimeItems;
  }

  List<DropdownMenuItem<String>> get endtimedropdownItems {
    List<DropdownMenuItem<String>> endtimeItems = [
      const DropdownMenuItem(child: Text("10:00"), value: "10:00"),
      const DropdownMenuItem(child: Text("11:30"), value: "11:30"),
      const DropdownMenuItem(child: Text("1:00"), value: "1:00"),
      const DropdownMenuItem(child: Text("3:00"), value: "3:00"),
      const DropdownMenuItem(child: Text("4:30"), value: "4:30"),
    ];
    return endtimeItems;
  }

  List<DropdownMenuItem<String>> get daydropdownItems {
    List<DropdownMenuItem<String>> dayItems = [
      const DropdownMenuItem(child: Text("Mon"), value: "Mon"),
      const DropdownMenuItem(child: Text("Tue"), value: "Tue"),
      const DropdownMenuItem(child: Text("Wed"), value: "Wed"),
      const DropdownMenuItem(child: Text("Thu"), value: "Thu"),
      const DropdownMenuItem(child: Text("Fri"), value: "Fri"),
    ];
    return dayItems;
  }
}
