// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, unused_local_variable, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Model/Admin/dvr.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/view_models/Admin/dvr_view_model.dart';
import 'package:live_streaming/widget/mytextfield.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';

import '../../../repo/Admin/dvr_services.dart';
import '../../../widget/mybutton.dart';

Future<dynamic> update_dvr(
    BuildContext context,
    TextEditingController host,
    TextEditingController ip,
    TextEditingController channel,
    TextEditingController pass,
    int id,
    DVRViewModel dvrViewModel,
    TextEditingController name) {
  return showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
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
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                Center(
                  child: Text("Update DVR",
                      style: GoogleFonts.bebasNeue(fontSize: 40)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "IP",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                mytextfiled("", ip, false),
                const Text(
                  "Channel",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                mytextfiled("", channel, false),
                const Text(
                  "Host",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                mytextfiled("", host, false),
                const Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                mytextfiled("", pass, false),
                const Text(
                  "Name",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                mytextfiled("", name, false),
                mybutton(() async {
                  if (ip.text.isNotEmpty &&
                      pass.text.isNotEmpty &&
                      channel.text.isNotEmpty &&
                      host.text.isNotEmpty &&
                      name.text.isNotEmpty) {
                    showLoaderDialog(context, 'Updating');
                    try {
                      DVR c = DVR(
                          ip: ip.text,
                          host: host.text,
                          channel: channel.text,
                          password: pass.text,
                          id: id,
                          name: name.text);

                      var res = await DVRServices.put(c);

                      if (res is Failure) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            snack_bar("${res.errorResponse}", false));
                      } else if (res is Success) {
                        dvrViewModel.getDvrData();
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                            snack_bar("DVR Updated Successfully...", true));
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
                }, "Update", Icons.update_sharp),
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
