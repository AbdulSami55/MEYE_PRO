// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, unused_local_variable, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/Api/dvr_api.dart';
import 'package:live_streaming/Model/Admin/DVR/DVR.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:velocity_x/velocity_x.dart';

Future<dynamic> add_dvr(
  BuildContext context,
  TextEditingController host,
  TextEditingController ip,
  TextEditingController channel,
  TextEditingController pass,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Add Camera"),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.60,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: VxTextField(
                  controller: ip,
                  labelText: "Enter  IP",
                  hint: "Enter  IP",
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
                  controller: channel,
                  labelText: "Enter  Channel",
                  hint: "Enter  Channel",
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
                  controller: host,
                  labelText: "Enter Host",
                  hint: "Enter Host",
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
                  controller: pass,
                  labelText: "Enter Password",
                  hint: "Enter Password",
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
                    host.text.isNotEmpty &&
                    pass.text.isNotEmpty &&
                    channel.text.isNotEmpty) {
                  showLoaderDialog(context, 'Adding');
                  try {
                    DVR c = DVR(
                        ip: ip.text,
                        host: host.text,
                        channel: channel.text,
                        password: pass.text);
                    DVRApi api = DVRApi();
                    String res = await api.post(c);

                    if (res == "okay") {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          snack_bar("DVR Added Successfully...", true));
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
