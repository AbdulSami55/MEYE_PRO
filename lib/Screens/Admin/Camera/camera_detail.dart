// ignore_for_file: must_be_immutable, non_constant_identifier_names, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Bloc/DVRDetailsBloc.dart';
import 'package:live_streaming/Controller/dvr.dart';
import 'package:live_streaming/Model/Admin/Camera/camera.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/widget/Camera/add_camera.dart';
import 'package:live_streaming/widget/Camera/delete_camera.dart';
import 'package:live_streaming/widget/Camera/update_camera.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../Bloc/CameraDetailsBloc.dart';

class CameraDetails extends StatefulWidget {
  CameraDetails({super.key, required this.index});
  int index;
  @override
  State<CameraDetails> createState() => _CameraDetailsState();
}

class _CameraDetailsState extends State<CameraDetails> {
  final cameradetailbloc = CameraDetailsBloc();
  TextEditingController room = TextEditingController();
  TextEditingController no = TextEditingController();

  @override
  void initState() {
    cameradetailbloc.id = Provider.of<DVRController>(context, listen: false)
        .lstDVR[widget.index]
        .id;
    cameradetailbloc.context = context;
    cameradetailbloc.eventsinkCameraDetails.add(CameraDetailsAction.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DVRController>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            foregroundColor: shadowColorDark,
            backgroundColor: backgroundColor,
            snap: false,
            pinned: true,
            floating: false,
            title: Text(
              "Details",
              style: GoogleFonts.poppins(fontSize: 25, color: shadowColorDark),
            ),
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 7),
                            color: Colors.grey.withOpacity(0.5))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Host",
                              style: GoogleFonts.bebasNeue(fontSize: 25),
                            ),
                            Text(
                              DVRDetailsBloc.lst[widget.index].host!,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 25, color: Colors.grey),
                            ),
                          ],
                        ).pOnly(left: 10, right: 10, top: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "IP",
                              style: GoogleFonts.bebasNeue(fontSize: 25),
                            ),
                            Text(
                              DVRDetailsBloc.lst[widget.index].ip!,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 25, color: Colors.grey),
                            ),
                          ],
                        ).pOnly(left: 10, right: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Password",
                              style: GoogleFonts.bebasNeue(fontSize: 25),
                            ),
                            Text(
                              DVRDetailsBloc.lst[widget.index].password!,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 25, color: Colors.grey),
                            ),
                          ],
                        ).pOnly(left: 10, right: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Channel",
                              style: GoogleFonts.bebasNeue(fontSize: 25),
                            ),
                            Text(
                              DVRDetailsBloc.lst[widget.index].channel!,
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 25, color: Colors.grey),
                            ),
                          ],
                        ).pOnly(left: 10, right: 10, bottom: 5),
                      ],
                    ),
                  ),
                ).pOnly(bottom: 10, top: 10, right: 10, left: 10),
                CupertinoSearchTextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    // CameraSearchMutation(value);
                  },
                  decoration: BoxDecoration(
                    color: backgroundColorLight,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ).pOnly(left: 12, right: 12, bottom: 5),
                const SizedBox(
                  height: 10,
                ),
                Camera_Details_List(controller, room, no)
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<DropdownMenuItem<String>> channelItems = [];
          if (controller.lstchannel.isNotEmpty) {
            controller.channel = controller.lstchannel.first;
            for (String i in controller.lstchannel) {
              channelItems.add(
                DropdownMenuItem(value: i, child: Text(i)),
              );
            }
            List<DropdownMenuItem<Venue>> venueItems = [];
            if (controller.lstvenue.isNotEmpty) {
              controller.venue = controller.lstvenue[0].name;
              controller.venueid = controller.lstvenue[0].id;
              controller.v = controller.lstvenue[0];
              for (Venue i in controller.lstvenue) {
                venueItems.add(
                  DropdownMenuItem(value: i, child: Text(i.name)),
                );
              }
              add_camera(context, DVRDetailsBloc.lst[widget.index].id!,
                  venueItems, channelItems, cameradetailbloc);
            }
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(snack_bar("No Channel Left...", false));
          }
        },
        backgroundColor: primaryColor,
        foregroundColor: containerColor,
        child: const Icon(
          Icons.add_a_photo_outlined,
        ),
      ),
    );
  }

  StreamBuilder<List<Camera>> Camera_Details_List(DVRController controller,
      TextEditingController room, TextEditingController no) {
    return StreamBuilder<List<Camera>>(
        stream: cameradetailbloc.streamCameraDetails,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Center(
                        child: Text(
                      'No Data',
                      style: GoogleFonts.bebasNeue(fontSize: 40),
                    )))
                : Consumer<DVRController>(
                    builder: (context, controller, child) => GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: controller.lstCamera.length,
                          itemBuilder: ((context, index) => Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 7),
                                          blurRadius: 7,
                                          spreadRadius: 3,
                                          color: Colors.grey.withOpacity(0.5))
                                    ],
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Room",
                                          style: GoogleFonts.bebasNeue(
                                              fontSize: 25),
                                        ),
                                        Text(
                                            controller.lstvenue
                                                .where((element) =>
                                                    element.id ==
                                                    controller
                                                        .lstCamera[index].vid)
                                                .firstOrNull()
                                                .name
                                                .toString(),
                                            style: GoogleFonts.bebasNeue(
                                                fontSize: 25)),
                                      ],
                                    ).pOnly(
                                      top: 18,
                                      right: 12,
                                      left: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Channel",
                                            style: GoogleFonts.bebasNeue(
                                                fontSize: 25)),
                                        Text(
                                            controller.lstCamera[index].no
                                                .toString(),
                                            style: GoogleFonts.bebasNeue(
                                                fontSize: 25)),
                                      ],
                                    ).pOnly(left: 12, right: 12),
                                    Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12.0),
                                              topRight: Radius.circular(12.0)),
                                          color: primaryColor),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    List<
                                                            DropdownMenuItem<
                                                                String>>
                                                        channelItems = [];
                                                    List<
                                                            DropdownMenuItem<
                                                                Venue>>
                                                        venueItems = [];
                                                    if (controller.lstchannel
                                                        .contains(controller
                                                            .lstCamera[index]
                                                            .no)) {
                                                    } else {
                                                      controller.lstchannel.add(
                                                          controller
                                                              .lstCamera[index]
                                                              .no
                                                              .toString());
                                                    }

                                                    String value = controller
                                                        .lstCamera[index].no
                                                        .toString();

                                                    controller.channel =
                                                        controller
                                                            .lstchannel.last;
                                                    channelItems.add(
                                                      DropdownMenuItem(
                                                          value: controller
                                                              .channel,
                                                          child: Text(controller
                                                              .channel!)),
                                                    );

                                                    for (int i = 0;
                                                        i <
                                                            controller
                                                                    .lstchannel
                                                                    .length -
                                                                1;
                                                        i++) {
                                                      channelItems.add(
                                                        DropdownMenuItem(
                                                            value: controller
                                                                .lstchannel[i],
                                                            child: Text(controller
                                                                    .lstchannel[
                                                                i])),
                                                      );
                                                    }
                                                    Venue v = controller
                                                        .lstvenue
                                                        .where((element) =>
                                                            element.id ==
                                                            controller
                                                                .lstCamera[
                                                                    index]
                                                                .vid)
                                                        .firstOrNull();

                                                    controller.v = v;
                                                    List<Venue> templst = [];
                                                    for (int i = 0;
                                                        i <
                                                            controller.lstvenue
                                                                .length;
                                                        i++) {
                                                      if (controller
                                                              .lstvenue[i] !=
                                                          v) {
                                                        templst.add(controller
                                                            .lstvenue[i]);
                                                      }
                                                    }
                                                    venueItems.add(
                                                      DropdownMenuItem(
                                                          value: v,
                                                          child: Text(v.name)),
                                                    );

                                                    for (int i = 0;
                                                        i < templst.length;
                                                        i++) {
                                                      venueItems.add(
                                                        DropdownMenuItem(
                                                            value: templst[i],
                                                            child: Text(
                                                                templst[i]
                                                                    .name)),
                                                      );
                                                    }

                                                    Camera c = Camera(
                                                        controller
                                                            .lstCamera[index]
                                                            .id,
                                                        controller
                                                            .lstCamera[index]
                                                            .did,
                                                        controller
                                                            .lstCamera[index]
                                                            .vid,
                                                        controller
                                                            .lstCamera[index]
                                                            .no);
                                                    controller.oldcamera = c;
                                                    room.text = controller
                                                        .lstCamera[index].vid
                                                        .toString();
                                                    update_camera(
                                                        context,
                                                        controller
                                                            .lstCamera[index]
                                                            .id!,
                                                        controller
                                                            .lstDVR[
                                                                widget.index]
                                                            .id!,
                                                        venueItems,
                                                        channelItems,
                                                        controller
                                                            .lstCamera[index]
                                                            .no!,
                                                        value,
                                                        cameradetailbloc);
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: containerColor,
                                                  )),
                                              InkWell(
                                                onTap: () {
                                                  delete_camera(
                                                      context,
                                                      controller
                                                          .lstCamera[index].id!,
                                                      controller
                                                          .lstDVR[widget.index]
                                                          .id!,
                                                      controller
                                                          .lstCamera[index]
                                                          .vid!,
                                                      controller
                                                          .lstCamera[index].no
                                                          .toString(),
                                                      cameradetailbloc);
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              )
                                            ],
                                          ).pOnly(left: 10, right: 10),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.013,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ).pOnly(left: 12, right: 12)),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.height * 0.5,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing:
                                      MediaQuery.of(context).size.height * 0.02,
                                  mainAxisSpacing:
                                      MediaQuery.of(context).size.height *
                                          0.02),
                        ));
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
        }));
  }
}
