// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:provider/provider.dart';
import '../../../Bloc/CameraDetailsBloc.dart';
import '../../../view_models/dvr_view_model.dart';
import 'delete_dvr.dart';
import 'update_dvr.dart';
import '../../../widget/components/apploading.dart';
import '../../../widget/components/errormessage.dart';
import '../Camera/camera_detail.dart';

class DVRDetails extends StatelessWidget {
  DVRDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController ip = TextEditingController();
    TextEditingController host = TextEditingController();
    TextEditingController channel = TextEditingController();
    TextEditingController pass = TextEditingController();
    TextEditingController name = TextEditingController();
    DVRViewModel dvrViewModel = context.watch<DVRViewModel>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: backgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.3,
                        right: MediaQuery.of(context).size.width / 20,
                        left: MediaQuery.of(context).size.width / 20,
                      ),
                      child: CupertinoSearchTextField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // SearchMutation(value);
                        },
                        decoration: BoxDecoration(
                          color: backgroundColorLight,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            expandedHeight: 130,
            automaticallyImplyLeading: false,
            snap: true,
            pinned: true,
            floating: true,
            title: Row(
              children: [
                Text(
                  "DVR Details",
                  style: GoogleFonts.poppins(fontSize: 30, color: Colors.black),
                ),
              ],
            ),
            elevation: 0,
          ),
          SliverToBoxAdapter(
              child: _ui(dvrViewModel, ip, host, channel, pass, name))
        ],
      ),
    );
  }

  _ui(
      DVRViewModel dvrViewModel,
      TextEditingController ip,
      TextEditingController host,
      TextEditingController channel,
      TextEditingController pass,
      TextEditingController name) {
    if (dvrViewModel.loading) {
      return apploading();
    }
    if (dvrViewModel.userError != null) {
      return ErrorMessage(dvrViewModel.userError!.message.toString());
    }
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: dvrViewModel.lstDVR.length,
        itemBuilder: ((context, index) => InkWell(
              onTap: () {
                CameraDetailsBloc.index = index;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CameraDetails(
                              index: index,
                            ))));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 7),
                            color: Colors.grey.withOpacity(0.5))
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.camera_alt_rounded,
                          size: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Name: ${dvrViewModel.lstDVR[index].name}',
                              style: GoogleFonts.bebasNeue(fontSize: 25),
                            ),
                            Text(
                              'IP: ${dvrViewModel.lstDVR[index].ip}\nPassword: ${dvrViewModel.lstDVR[index].password}\nChannel: ${dvrViewModel.lstDVR[index].channel}\n',
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 25, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  host.text = dvrViewModel.lstDVR[index].host!;
                                  ip.text = dvrViewModel.lstDVR[index].ip!;
                                  channel.text =
                                      dvrViewModel.lstDVR[index].channel!;
                                  pass.text =
                                      dvrViewModel.lstDVR[index].password!;
                                  name.text = dvrViewModel.lstDVR[index].name
                                      .toString();
                                  update_dvr(
                                      context,
                                      host,
                                      ip,
                                      channel,
                                      pass,
                                      dvrViewModel.lstDVR[index].id!,
                                      dvrViewModel,
                                      name);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 30,
                                )),
                            IconButton(
                              onPressed: () {
                                host.text = dvrViewModel.lstDVR[index].host!;
                                ip.text = dvrViewModel.lstDVR[index].ip!;
                                channel.text =
                                    dvrViewModel.lstDVR[index].channel!;
                                pass.text =
                                    dvrViewModel.lstDVR[index].password!;
                                name.text = dvrViewModel.lstDVR[index].name!;
                                delete_dvr(
                                    context,
                                    host,
                                    ip,
                                    channel,
                                    pass,
                                    dvrViewModel.lstDVR[index].id!,
                                    name,
                                    dvrViewModel);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 30,
                              ),
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            )));
  }
}
