// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, unused_local_variable, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/Api/camera_api.dart';
import 'package:live_streaming/Model/Admin/Camera/Camera.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:velocity_x/velocity_x.dart';

Future<dynamic> add_camera(BuildContext context, TextEditingController ip,
    TextEditingController lt, TextEditingController no) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Add Camera"),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.48,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: VxTextField(
                  controller: ip,
                  labelText: "Enter Camera IP",
                  hint: "Enter Camera IP",
                  labelStyle: const TextStyle(color: Colors.white),
                  borderType: VxTextFieldBorderType.roundLine,
                  borderRadius: 20.0),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: VxTextField(
                  controller: no,
                  labelText: "Enter Camera Number",
                  hint: "Enter Camera Number",
                  labelStyle: const TextStyle(color: Colors.white),
                  borderType: VxTextFieldBorderType.roundLine,
                  borderRadius: 20.0),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: VxTextField(
                  controller: lt,
                  labelText: "Enter LT/LAB Name",
                  hint: "Enter LT/LAB Name",
                  labelStyle: const TextStyle(color: Colors.white),
                  borderType: VxTextFieldBorderType.roundLine,
                  borderRadius: 20.0),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () async {
                if (ip.text.isNotEmpty &&
                    lt.text.isNotEmpty &&
                    no.text.isNotEmpty) {
                  showLoaderDialog(context, 'Adding');
                  try {
                    Camera c = Camera(ip: ip.text, lt: lt.text, no: no.text);
                    CameraApi api = CameraApi();
                    String res = await api.post(c);

                    if (res == "okay") {
                      Navigator.pop(context);
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
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snack_bar("Fill All Fields...", false));
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.94,
                decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                height: MediaQuery.of(context).size.height * 0.09,
                child: const Center(
                    child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
