// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, unused_local_variable, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/repo/Admin/camera_service.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import '../../../Model/Admin/camera.dart';
import '../../../view_models/camera_view_model.dart';
import '../../../widget/snack_bar.dart';

Future<dynamic> delete_camera(BuildContext context, int id, int dvrID,
    int venueID, String no, CameraViewModel cameraViewModel) {
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
                Camera c = Camera(
                    id: id, dvrID: dvrID, venueID: venueID, portNumber: no);

                var res = await CameraServies.delete(c);
                Navigator.pop(context);
                if (res is Success) {
                  cameraViewModel.getCameraData();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      snack_bar("DVR Deleted Successfully...", true));
                } else if (res is Failure) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      snack_bar(res.errorResponse.toString(), false));
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
