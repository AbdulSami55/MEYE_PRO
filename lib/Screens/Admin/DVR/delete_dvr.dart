// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, unused_local_variable, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/view_models/dvr_view_model.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import '../../../Model/Admin/dvr.dart';
import '../../../repo/Admin/dvr_services.dart';
import '../../../widget/snack_bar.dart';

Future<dynamic> delete_dvr(
    BuildContext context,
    TextEditingController host,
    TextEditingController ip,
    TextEditingController channel,
    TextEditingController pass,
    int id,
    TextEditingController name,
    DVRViewModel dvrViewModel) {
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
              if (ip.text.isNotEmpty &&
                  pass.text.isNotEmpty &&
                  host.text.isNotEmpty &&
                  channel.text.isNotEmpty &&
                  name.text.isNotEmpty) {
                showLoaderDialog(context, 'Deleting');
                try {
                  DVR c = DVR(
                      ip: ip.text,
                      host: host.text,
                      channel: channel.text,
                      password: pass.text,
                      id: id,
                      name: name.text);

                  dynamic res = await DVRServices.delete(c);
                  Navigator.pop(context);
                  if (res is Success) {
                    dvrViewModel.getDvrData();

                    ScaffoldMessenger.of(context).showSnackBar(
                        snack_bar("DVR Deleted Successfully...", true));
                    Navigator.pop(context);
                  } else if (res is Failure) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snack_bar("${res.errorResponse}", false));
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
