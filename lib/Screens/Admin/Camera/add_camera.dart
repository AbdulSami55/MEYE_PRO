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

Future<dynamic> add_camera(
    BuildContext context,
    int did,
    List<DropdownMenuItem<Venue>> venue,
    List<DropdownMenuItem<String>> channelItems,
    CameraDetailsBloc cameraDetailsBloc) {
  return showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
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
                Center(
                  child: Text("Add Camera",
                      style: GoogleFonts.bebasNeue(fontSize: 40)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<DVRViewModel>(
                  builder: (context, controller, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Venue",
                      ),
                      DropdownButton<Venue>(
                        isExpanded: true,
                        value: Provider.of<DVRViewModel>(context).v,
                        items: venue,
                        onChanged: (value) {
                          Provider.of<DVRViewModel>(context, listen: false)
                              .newvenueid(value!.id);
                          Provider.of<DVRViewModel>(context, listen: false)
                              .newVenue(value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<DVRViewModel>(
                  builder: (context, controller, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Channel",
                      ),
                      DropdownButton(
                        isExpanded: true,
                        value: Provider.of<DVRViewModel>(context).channel,
                        items: channelItems,
                        onChanged: (value) {
                          Provider.of<DVRViewModel>(context, listen: false)
                              .newchannel(value!);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                mybutton(() async {
                  showLoaderDialog(context, 'Adding');
                  try {
                    Camera c = Camera(
                      id: 0,
                      did: did,
                      vid: Provider.of<DVRViewModel>(context, listen: false)
                          .venueid,
                      no: Provider.of<DVRViewModel>(context, listen: false)
                          .channel
                          .toString(),
                    );
                    CameraApi api = CameraApi();
                    String res = await api.post(c);

                    if (res == "okay") {
                      Navigator.pop(context);
                      cameraDetailsBloc.eventsinkCameraDetails
                          .add(CameraDetailsAction.Fetch);

                      ScaffoldMessenger.of(context).showSnackBar(
                          snack_bar("Camera Added Successfully...", true));
                    } else {
                      Navigator.pop(context);
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
                }, "Add", Icons.add)
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
