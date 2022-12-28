// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, unused_local_variable, unrelated_type_equality_checks, use_build_context_synchronously, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/repo/camera_api.dart';
import 'package:live_streaming/Bloc/CameraDetailsBloc.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:provider/provider.dart';

import '../../../Model/Admin/camera.dart';
import '../../../view_models/dvr_view_model.dart';

Future<dynamic> update_camera(
    BuildContext context,
    int id,
    int did,
    List<DropdownMenuItem<Venue>> venueItems,
    List<DropdownMenuItem<String>> channelItems,
    String no,
    String value,
    CameraDetailsBloc cameraDetailsBloc) {
  return showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.70,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 30),
                blurRadius: 60,
              ),
              const BoxShadow(
                color: Colors.black45,
                offset: Offset(0, 30),
                blurRadius: 60,
              ),
            ],
          ),
          child: Scaffold(
            body: ListView(
              children: [
                Row(
                  children: [
                    Center(
                      child: Text("Update Camera",
                          style: GoogleFonts.bebasNeue(fontSize: 40)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          Provider.of<DVRViewModel>(context, listen: false)
                              .lstchannel
                              .remove(value);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.cancel)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<DVRViewModel>(
                  builder: (context, controller, status) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Venue",
                      ),
                      DropdownButton<Venue>(
                        isExpanded: true,
                        value: Provider.of<DVRViewModel>(context).v,
                        items: venueItems,
                        onChanged: (value) {
                          controller.newVenue(value!);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<DVRViewModel>(
                  builder: (context, controller, status) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Channel",
                      ),
                      DropdownButton(
                        isExpanded: true,
                        value: controller.channel,
                        items: channelItems,
                        onChanged: (value) {
                          controller.newchannel(value.toString());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                mybutton(() async {
                  showLoaderDialog(context, 'Updating');
                  try {
                    Camera c = Camera(
                      id: id,
                      did: did,
                      vid: Provider.of<DVRViewModel>(context, listen: false)
                          .v!
                          .id,
                      no: Provider.of<DVRViewModel>(context, listen: false)
                          .channel
                          .toString(),
                    );
                    CameraApi api = CameraApi();
                    var res = await api.put(c);

                    if (res == "Something went wrong") {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          snack_bar("Something Went Wrong...", false));
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          snack_bar("Camera Updated Successfully...", true));
                      cameraDetailsBloc.eventsinkCameraDetails
                          .add(CameraDetailsAction.Fetch);
                    }
                    Navigator.pop(context);
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        snack_bar("Something Went Wrong...", false));
                    Navigator.pop(context);
                  }
                }, "Update", Icons.update)
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;

      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
  );
}
