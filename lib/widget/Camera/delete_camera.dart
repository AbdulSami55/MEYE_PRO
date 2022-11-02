// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:live_streaming/Bloc/CameraDetailsBloc.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../Api/camera_api.dart';
import '../../Model/Admin/Camera/Camera.dart';
import '../progress_dialogue.dart';
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
                ProgressDialog pd = Progress_Dialogue(context, 'Deleting..');
                await pd.show();
                try {
                  if (pd.isShowing()) {
                    Camera c = Camera(ip: ip.text, lt: lt.text, no: no.text);
                    CameraApi api = CameraApi();
                    String res = await api.delete(c);

                    Future.delayed(const Duration(seconds: 1)).then((value) =>
                        pd.hide().then((value) {
                          if (res == "okay") {
                            cameraDetailsBloc.eventsinkCameraDetails
                                .add(CameraDetailsAction.Fetch);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                snack_bar("Camera Deleted Successfully..."));
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                snack_bar("Something Went Wrong..."));
                          }
                        }));
                  }
                } catch (e) {
                  Future.delayed(const Duration(seconds: 1))
                      .then((value) => pd.hide().then((value) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                snack_bar("Something Went Wrong..."));
                          }));
                }
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(snack_bar("Fill All Fields..."));
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
