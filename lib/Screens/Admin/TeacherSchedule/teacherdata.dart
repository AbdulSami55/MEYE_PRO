// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Bloc/teacherDetailsBloc.dart';
import 'package:live_streaming/Model/Admin/schedule.dart';
import 'package:live_streaming/Model/Teacher/teacher.dart';
import 'package:live_streaming/Screens/Admin/TeacherSchedule/setschedule.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../Store/Admin/setscheduleSearch.dart';

class Teacherdata extends StatefulWidget {
  const Teacherdata({super.key});

  @override
  State<Teacherdata> createState() => _TeacherdataState();
}

class _TeacherdataState extends State<Teacherdata> {
  final teacherbloc = TeacherDetailsBloc();
  @override
  void initState() {
    teacherbloc.eventsinkTeacherDetails.add(TeacherDetailsAction.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = (VxState.store as MyStore);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.grey[850],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.3,
                        right: MediaQuery.of(context).size.width / 20,
                        left: MediaQuery.of(context).size.width / 20,
                      ),
                      child: CupertinoSearchTextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          TeacherSearchMutation(value);
                        },
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            expandedHeight: 130,
            automaticallyImplyLeading: false,
            snap: true,
            pinned: true,
            floating: true,
            title: Text(
              "Teacher Data",
              style: GoogleFonts.poppins(fontSize: 30),
            ),
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Teacher_Data_List(store),
          )
        ],
      ),
    );
  }

  VxBuilder<Object?> Teacher_Data_List(MyStore store) {
    return VxBuilder(
      builder: ((context, stor, status) => StreamBuilder<List<TeacherData>>(
          stream: teacherbloc.streamTeacherDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Center(
                          child: Text(
                        'No Data',
                        style: GoogleFonts.bebasNeue(fontSize: 40),
                      )))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Column(
                            children: [
                              InkWell(
                                onTap: (() {
                                  store.scheduleindex = index;
                                  VxBottomSheet.bottomSheetOptions(context,
                                      roundedFromTop: true,
                                      option: ["Add", "View", "Update"],
                                      backgroundColor: Colors.black,
                                      onSelect: BottomSheet);
                                }),
                                child: ListTile(
                                  title: Text(store.lstteacher![index].tNAME
                                      .toString()),
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: MemoryImage(base64Decode(
                                        store.lstteacher![index].tIMAGE
                                            .toString())),
                                  ),
                                ),
                              ),
                              const Divider().pOnly(left: 20, right: 20)
                            ],
                          ),
                      itemCount: store.lstteacher!.length);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                  ),
                  const Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: Text('No Data'));
            }
          })),
      mutations: const {TeacherSearchMutation},
    );
  }

  void BottomSheet(int index, String Value) {
    if (Value == "Add") {
      Navigator.push(context, MaterialPageRoute(builder: ((context) {
        TeacherSchedule ts = TeacherSchedule(
            room: '',
            tid: (VxState.store as MyStore).lstteacher![index].tID.toString(),
            displine: 'BCS',
            sec: 'A',
            sem: '1',
            starttime: '8:30',
            endtime: '10:00',
            fmin: false,
            lmin: false,
            full: false,
            coursename: '',
            day: "Mon");
        (VxState.store as MyStore).teacherSchedule = ts;
        return SetSchedule(
          index: (VxState.store as MyStore).scheduleindex!,
        );
      })));
    } else if (Value == "View") {
    } else {}
  }
}
