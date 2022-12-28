// ignore_for_file: must_be_immutable, non_constant_identifier_names, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/Screens/Admin/Camera/add_camera.dart';
import 'package:live_streaming/Screens/Admin/Camera/delete_camera.dart';
import 'package:live_streaming/Screens/Admin/Camera/update_camera.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:provider/provider.dart';
import '../../../Bloc/CameraDetailsBloc.dart';
import '../../../Model/Admin/camera.dart';
import '../../../view_models/dvr_view_model.dart';

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
    cameradetailbloc.id = Provider.of<DVRViewModel>(context, listen: false)
        .lstDVR[widget.index]
        .id;
    cameradetailbloc.context = context;
    cameradetailbloc.eventsinkCameraDetails.add(CameraDetailsAction.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DVRViewModel>(context);
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
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(10.0),
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
                                controller.lstDVR[widget.index].host!,
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 25, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "IP",
                                style: GoogleFonts.bebasNeue(fontSize: 25),
                              ),
                              Text(
                                controller.lstDVR[widget.index].ip!,
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 25, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Password",
                                style: GoogleFonts.bebasNeue(fontSize: 25),
                              ),
                              Text(
                                controller.lstDVR[widget.index].password!,
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 25, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Channel",
                                style: GoogleFonts.bebasNeue(fontSize: 25),
                              ),
                              Text(
                                controller.lstDVR[widget.index].channel!,
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 25, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoSearchTextField(
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
                  ),
                ),
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
              add_camera(context, controller.lstDVR[widget.index].id!,
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

  StreamBuilder<List<Camera>> Camera_Details_List(DVRViewModel controller,
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
                : Consumer<DVRViewModel>(
                    builder: (context, controller, child) => Wrap(
                        direction: Axis.horizontal,
                        children: controller.lstCamera
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(0, 7),
                                              blurRadius: 7,
                                              spreadRadius: 3,
                                              color:
                                                  Colors.grey.withOpacity(0.5))
                                        ],
                                        color: containerColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0, top: 6.0),
                                          child: Row(
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
                                                          element.id == e.vid)
                                                      .first
                                                      .name
                                                      .toString(),
                                                  style: GoogleFonts.bebasNeue(
                                                      fontSize: 25)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Channel",
                                                  style: GoogleFonts.bebasNeue(
                                                      fontSize: 25)),
                                              Text(e.no.toString(),
                                                  style: GoogleFonts.bebasNeue(
                                                      fontSize: 25)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(12.0),
                                                  topRight:
                                                      Radius.circular(12.0)),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                        if (controller
                                                            .lstchannel
                                                            .contains(e.no)) {
                                                        } else {
                                                          controller.lstchannel
                                                              .add(e.no
                                                                  .toString());
                                                        }

                                                        String value =
                                                            e.no.toString();

                                                        controller.channel =
                                                            controller
                                                                .lstchannel
                                                                .last;
                                                        channelItems.add(
                                                          DropdownMenuItem(
                                                              value: controller
                                                                  .channel,
                                                              child: Text(
                                                                  controller
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
                                                                        .lstchannel[
                                                                    i],
                                                                child: Text(
                                                                    controller
                                                                            .lstchannel[
                                                                        i])),
                                                          );
                                                        }
                                                        Venue v = controller
                                                            .lstvenue
                                                            .where((element) =>
                                                                element.id ==
                                                                e.vid)
                                                            .first;

                                                        controller.v = v;
                                                        List<Venue> templst =
                                                            [];
                                                        for (int i = 0;
                                                            i <
                                                                controller
                                                                    .lstvenue
                                                                    .length;
                                                            i++) {
                                                          if (controller
                                                                      .lstvenue[
                                                                  i] !=
                                                              v) {
                                                            templst.add(controller
                                                                .lstvenue[i]);
                                                          }
                                                        }
                                                        venueItems.add(
                                                          DropdownMenuItem(
                                                              value: v,
                                                              child:
                                                                  Text(v.name)),
                                                        );

                                                        for (int i = 0;
                                                            i < templst.length;
                                                            i++) {
                                                          venueItems.add(
                                                            DropdownMenuItem(
                                                                value:
                                                                    templst[i],
                                                                child: Text(
                                                                    templst[i]
                                                                        .name)),
                                                          );
                                                        }

                                                        Camera c = Camera(
                                                            id: e.id,
                                                            did: e.did,
                                                            vid: e.vid,
                                                            no: e.no);
                                                        controller.oldcamera =
                                                            c;
                                                        room.text =
                                                            e.vid.toString();
                                                        update_camera(
                                                            context,
                                                            e.id!,
                                                            controller
                                                                .lstDVR[widget
                                                                    .index]
                                                                .id!,
                                                            venueItems,
                                                            channelItems,
                                                            e.no!,
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
                                                          e.id!,
                                                          controller
                                                              .lstDVR[
                                                                  widget.index]
                                                              .id!,
                                                          e.vid!,
                                                          e.no.toString(),
                                                          cameradetailbloc);
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                ],
                                              ),
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
                                  ),
                                ))
                            .toList()));
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
