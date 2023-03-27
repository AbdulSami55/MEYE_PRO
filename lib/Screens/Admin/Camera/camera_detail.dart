// ignore_for_file: must_be_immutable, non_constant_identifier_names, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Model/Admin/camera.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/Screens/Admin/Camera/add_camera.dart';
import 'package:live_streaming/Screens/Admin/Camera/delete_camera.dart';
import 'package:live_streaming/Screens/Admin/Camera/update_camera.dart';
import 'package:live_streaming/view_models/Admin/DVR/camera_view_model.dart';
import 'package:live_streaming/view_models/Admin/venue_view_model.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:provider/provider.dart';
import '../../../view_models/Admin/DVR/dvr_view_model.dart';
import '../../../widget/components/appbar.dart';
import '../../../widget/components/errormessage.dart';

class CameraDetails extends StatelessWidget {
  CameraDetails({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    TextEditingController room = TextEditingController();
    TextEditingController no = TextEditingController();
    final controller = Provider.of<DVRViewModel>(context, listen: false);
    return ChangeNotifierProvider(
        create: (context) => CameraViewModel(controller.lstDVR[index]),
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              appbar("Details"),
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
                              mainCardRow(
                                  "Name", controller.lstDVR[index].name!),
                              mainCardRow(
                                  "Host", controller.lstDVR[index].host!),
                              mainCardRow("IP", controller.lstDVR[index].ip!),
                              mainCardRow("Password",
                                  controller.lstDVR[index].password!),
                              mainCardRow(
                                  "Channel", controller.lstDVR[index].channel!),
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
                    Consumer<CameraViewModel>(
                      builder: (context, provider, child) =>
                          Camera_Details_List(
                              context, controller, room, no, provider),
                    )
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Consumer<CameraViewModel>(
            builder: (context, provider, child) => FloatingActionButton(
              onPressed: () async {
                List<DropdownMenuItem<String>> channelItems = [];
                if (provider.lstchannel.isNotEmpty) {
                  Provider.of<VenueViewModel>(context, listen: false)
                      .selectedchannel = provider.lstchannel.first;
                  for (String i in provider.lstchannel) {
                    channelItems.add(
                      DropdownMenuItem(value: i, child: Text(i)),
                    );
                  }
                  List<DropdownMenuItem<Venue>> venueItems = [];
                  if (Provider.of<VenueViewModel>(context, listen: false)
                      .lstvenue
                      .isNotEmpty) {
                    Provider.of<VenueViewModel>(context, listen: false)
                            .selectedvenue =
                        Provider.of<VenueViewModel>(context, listen: false)
                            .lstvenue[0];

                    for (Venue i
                        in Provider.of<VenueViewModel>(context, listen: false)
                            .lstvenue) {
                      venueItems.add(
                        DropdownMenuItem(value: i, child: Text(i.name!)),
                      );
                    }
                    add_camera(context, controller.lstDVR[index].id!,
                        venueItems, channelItems);
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
          ),
        ));
  }

  Row mainCardRow(String righttext, String lefttext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          righttext,
          style: GoogleFonts.bebasNeue(fontSize: 25),
        ),
        Text(
          lefttext,
          style: GoogleFonts.bebasNeue(fontSize: 25, color: Colors.grey),
        ),
      ],
    );
  }

  Widget Camera_Details_List(
    BuildContext context,
    DVRViewModel controller,
    TextEditingController room,
    TextEditingController no,
    CameraViewModel cameraViewModel,
  ) {
    if (cameraViewModel.loading) {
      return apploading(context);
    } else if (cameraViewModel.userError != null) {
      return ErrorMessage(cameraViewModel.userError!.message.toString());
    } else if (Provider.of<VenueViewModel>(context).lstvenue.isEmpty) {
      return apploading(context);
    } else if (cameraViewModel.lstCamera.isEmpty) {
      return Center(
          child: Text(
        "No Channel Added",
        style: GoogleFonts.bebasNeue(fontSize: 30),
      ));
    }
    return cameraViewModel.lstCamera.length == 1
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              cameraCard(context, cameraViewModel.lstCamera[0], cameraViewModel,
                  controller),
            ],
          )
        : Wrap(
            direction: Axis.horizontal,
            children: cameraViewModel.lstCamera
                .map((e) => cameraCard(context, e, cameraViewModel, controller))
                .toList());
  }

  Padding cameraCard(BuildContext context, Camera e,
      CameraViewModel cameraViewModel, DVRViewModel controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(0, 7),
              blurRadius: 7,
              spreadRadius: 3,
              color: Colors.grey.withOpacity(0.5))
        ], color: containerColor, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Room",
                    style: GoogleFonts.bebasNeue(fontSize: 25),
                  ),
                  Text(
                      Provider.of<VenueViewModel>(context)
                          .lstvenue
                          .where((element) => element.id == e.venueID)
                          .first
                          .name
                          .toString(),
                      style: GoogleFonts.bebasNeue(fontSize: 25)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Channel", style: GoogleFonts.bebasNeue(fontSize: 25)),
                  Text(e.portNumber.toString(),
                      style: GoogleFonts.bebasNeue(fontSize: 25)),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0)),
                  color: primaryColor),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            List<DropdownMenuItem<String>> channelItems = [];
                            List<DropdownMenuItem<Venue>> venueItems = [];
                            if (cameraViewModel.lstchannel
                                .contains(e.portNumber)) {
                            } else {
                              cameraViewModel.lstchannel
                                  .add(e.portNumber.toString());
                            }

                            String value = e.portNumber.toString();

                            Provider.of<VenueViewModel>(context, listen: false)
                                    .selectedchannel =
                                cameraViewModel.lstchannel.last;
                            channelItems.add(
                              DropdownMenuItem(
                                  value: Provider.of<VenueViewModel>(context,
                                          listen: false)
                                      .selectedchannel,
                                  child: Text(Provider.of<VenueViewModel>(
                                          context,
                                          listen: false)
                                      .selectedchannel!)),
                            );

                            for (int i = 0;
                                i < cameraViewModel.lstchannel.length - 1;
                                i++) {
                              channelItems.add(
                                DropdownMenuItem(
                                    value: cameraViewModel.lstchannel[i],
                                    child: Text(cameraViewModel.lstchannel[i])),
                              );
                            }
                            Venue v = Provider.of<VenueViewModel>(context,
                                    listen: false)
                                .lstvenue
                                .where((element) => element.id == e.venueID)
                                .first;

                            Provider.of<VenueViewModel>(context, listen: false)
                                .selectedvenue = v;
                            List<Venue> templst = [];
                            for (int i = 0;
                                i <
                                    Provider.of<VenueViewModel>(context,
                                            listen: false)
                                        .lstvenue
                                        .length;
                                i++) {
                              if (Provider.of<VenueViewModel>(context,
                                          listen: false)
                                      .lstvenue[i] !=
                                  v) {
                                templst.add(Provider.of<VenueViewModel>(context,
                                        listen: false)
                                    .lstvenue[i]);
                              }
                            }
                            venueItems.add(
                              DropdownMenuItem(value: v, child: Text(v.name!)),
                            );

                            for (int i = 0; i < templst.length; i++) {
                              venueItems.add(
                                DropdownMenuItem(
                                    value: templst[i],
                                    child: Text(templst[i].name!)),
                              );
                            }

                            update_camera(
                                context,
                                e.id!,
                                controller.lstDVR[index].id!,
                                venueItems,
                                channelItems,
                                e.portNumber!,
                                value,
                                cameraViewModel);
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
                              controller.lstDVR[index].id!,
                              e.venueID!,
                              e.portNumber.toString(),
                              cameraViewModel);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.013,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
