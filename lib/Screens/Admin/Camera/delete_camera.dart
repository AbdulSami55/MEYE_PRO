// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, unused_local_variable, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/repo/camera_api.dart';
import 'package:live_streaming/Bloc/CameraDetailsBloc.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import '../../../Model/Admin/camera.dart';
import '../../../widget/snack_bar.dart';

Future<dynamic> delete_camera(BuildContext context, int id, int did, int vid,
    String no, CameraDetailsBloc cameraDetailsBloc) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete DVR"),
      content: const Text("Are You Sure?"),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("No"),
        ),
        ElevatedButton(
            onPressed: () async {
              showLoaderDialog(context, 'Deleting');
              try {
                Camera c = Camera(id: id, did: did, vid: vid, no: no);
                CameraApi api = CameraApi();
                String res = await api.delete(c);
                Navigator.pop(context);
                if (res == "okay") {
                  cameraDetailsBloc.eventsinkCameraDetails
                      .add(CameraDetailsAction.Fetch);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      snack_bar("DVR Deleted Successfully...", true));
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      snack_bar("Something Went Wrong...", false));
                }
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(snack_bar("Something Went Wrong...", false));
                Navigator.pop(context);
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
