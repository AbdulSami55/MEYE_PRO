// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, unused_local_variable, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/Bloc/CameraDetailsBloc.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import '../../Api/camera_api.dart';
import '../../Model/Admin/Camera/Camera.dart';
import '../snack_bar.dart';

Future<dynamic> delete_camera(
    BuildContext context,
    TextEditingController lt,
    TextEditingController ip,
    TextEditingController no,
    CameraDetailsBloc cameraDetailsBloc) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Camera"),
      content: const Text("Are You Sure?"),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("No"),
        ),
        ElevatedButton(
            onPressed: () async {
              if (ip.text.isNotEmpty &&
                  lt.text.isNotEmpty &&
                  no.text.isNotEmpty) {
                showLoaderDialog(context, 'Deleting');
                try {
                  Camera c = Camera(ip: ip.text, lt: lt.text, no: no.text);
                  CameraApi api = CameraApi();
                  String res = await api.delete(c);
                  Navigator.pop(context);
                  if (res == "okay") {
                    cameraDetailsBloc.eventsinkCameraDetails
                        .add(CameraDetailsAction.Fetch);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        snack_bar("Camera Deleted Successfully...", true));
                  } else {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        snack_bar("Something Went Wrong...", false));
                  }
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      snack_bar("Something Went Wrong...", false));
                  Navigator.pop(context);
                }
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(snack_bar("Fill All Fields...", false));
              }
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.white),
            ))
      ],
    ),
  );
}
