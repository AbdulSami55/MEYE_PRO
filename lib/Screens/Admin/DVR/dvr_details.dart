// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Screens/Admin/Teacher/teacher_details.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:provider/provider.dart';
import '../../../view_models/Admin/DVR/dvr_view_model.dart';
import 'delete_dvr.dart';
import 'update_dvr.dart';
import '../../../widget/components/apploading.dart';
import '../../../widget/components/errormessage.dart';
import '../Camera/camera_detail.dart';

class DVRDetails extends StatelessWidget {
  const DVRDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController ip = TextEditingController();
    TextEditingController host = TextEditingController();
    TextEditingController channel = TextEditingController();
    TextEditingController pass = TextEditingController();
    TextEditingController name = TextEditingController();
    DVRViewModel dvrViewModel = context.watch<DVRViewModel>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: backgroundColor,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.dvr,
                    ),
                    text: "DVR",
                  ),
                  Tab(icon: Icon(Icons.person), text: "Teacher"),
                  Tab(icon: Icon(Icons.video_collection), text: "Recordings"),
                ],
              ),
              expandedHeight: 130,
              automaticallyImplyLeading: false,
              snap: true,
              pinned: true,
              floating: true,
              title: Row(
                children: [
                  Text(
                    "Details",
                    style: GoogleFonts.poppins(
                        fontSize: 30, color: shadowColorDark),
                  ),
                ],
              ),
              elevation: 0,
            ),
          ],
          body: TabBarView(children: [
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                  child: CupertinoSearchTextField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      // SearchMutation(value);
                    },
                    decoration: BoxDecoration(
                      color: backgroundColorLight,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _ui(dvrViewModel, ip, host, channel, pass, name),
              ),
            ]),
            TeacherDetails(),
            TeacherDetails(),
          ]),
        ),
      ),
    );
  }

  _ui(
      DVRViewModel dvrViewModel,
      TextEditingController ip,
      TextEditingController host,
      TextEditingController channel,
      TextEditingController pass,
      TextEditingController name) {
    if (dvrViewModel.loading) {
      return apploading();
    }
    if (dvrViewModel.userError != null) {
      return ErrorMessage(dvrViewModel.userError!.message.toString());
    }
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: dvrViewModel.lstDVR.length,
        itemBuilder: ((context, index) => InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return CameraDetails(
                    index: index,
                  );
                })));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.265,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 7),
                            color: Colors.grey.withOpacity(0.5))
                      ],
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.height * 0.12,
                          height: MediaQuery.of(context).size.height * 0.265,
                          decoration: const BoxDecoration(
                              color: backgroundColor2,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(99))),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: backgroundColorLight,
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'Name: ${dvrViewModel.lstDVR[index].name}',
                              style: GoogleFonts.bebasNeue(fontSize: 24),
                            ),
                            Text(
                              'IP: ${dvrViewModel.lstDVR[index].ip}\nPassword: ${dvrViewModel.lstDVR[index].password}\nChannel: ${dvrViewModel.lstDVR[index].channel}',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 24, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  host.text = dvrViewModel.lstDVR[index].host!;
                                  ip.text = dvrViewModel.lstDVR[index].ip!;
                                  channel.text =
                                      dvrViewModel.lstDVR[index].channel!;
                                  pass.text =
                                      dvrViewModel.lstDVR[index].password!;
                                  name.text = dvrViewModel.lstDVR[index].name
                                      .toString();
                                  update_dvr(
                                      context,
                                      host,
                                      ip,
                                      channel,
                                      pass,
                                      dvrViewModel.lstDVR[index].id!,
                                      dvrViewModel,
                                      name);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 30,
                                )),
                            IconButton(
                              onPressed: () {
                                host.text = dvrViewModel.lstDVR[index].host!;
                                ip.text = dvrViewModel.lstDVR[index].ip!;
                                channel.text =
                                    dvrViewModel.lstDVR[index].channel!;
                                pass.text =
                                    dvrViewModel.lstDVR[index].password!;
                                name.text = dvrViewModel.lstDVR[index].name!;
                                delete_dvr(
                                    context,
                                    host,
                                    ip,
                                    channel,
                                    pass,
                                    dvrViewModel.lstDVR[index].id!,
                                    name,
                                    dvrViewModel);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 30,
                              ),
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.24,
                          width: 4,
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(99.0))),
                        )
                      ]),
                ),
              ),
            )));
  }
}
