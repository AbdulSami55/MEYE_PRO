// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Bloc/CameraDetailsBloc.dart';
import 'package:live_streaming/Bloc/DVRDetailsBloc.dart';
import 'package:live_streaming/Controller/dvr.dart';
import 'package:live_streaming/Model/Admin/DVR/dvr.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/widget/DVR/update_dvr.dart';
import 'package:provider/provider.dart';
import '../../../widget/DVR/delete_dvr.dart';
import '../Camera/camera_detail.dart';

class DVRDetails extends StatelessWidget {
  DVRDetails({super.key});

  final dvrdetailbloc = DVRDetailsBloc();

  @override
  Widget build(BuildContext context) {
    TextEditingController ip = TextEditingController();
    TextEditingController host = TextEditingController();
    TextEditingController channel = TextEditingController();
    TextEditingController pass = TextEditingController();
    TextEditingController name = TextEditingController();

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
            title: Text(
              "DVR Details",
              style: GoogleFonts.poppins(fontSize: 30, color: Colors.black),
            ),
            elevation: 0,
          ),
          SliverToBoxAdapter(
              child: FutureBuilder<List<DVR>>(
                  future: dvrdetailbloc.getData(context),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Center(
                                  child: Text(
                                'No Data',
                                style: GoogleFonts.bebasNeue(fontSize: 40),
                              )))
                          : Consumer<DVRController>(
                              builder: (context, controller, child) =>
                                  Container(
                                      child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: Provider.of<DVRController>(
                                                  context,
                                                  listen: false)
                                              .lstDVR
                                              .length,
                                          itemBuilder:
                                              ((context, index) => InkWell(
                                                    onTap: () {
                                                      CameraDetailsBloc.index =
                                                          index;
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: ((context) =>
                                                                  CameraDetails(
                                                                    index:
                                                                        index,
                                                                  ))));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      spreadRadius:
                                                                          3,
                                                                      blurRadius:
                                                                          7,
                                                                      offset:
                                                                          const Offset(
                                                                              0,
                                                                              7),
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.5))
                                                                ],
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            20.0))),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .camera_alt_rounded,
                                                                size: 50,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    'Name: ${controller.lstDVR[index].name}',
                                                                    style: GoogleFonts.bebasNeue(
                                                                        fontSize:
                                                                            25),
                                                                  ),
                                                                  Text(
                                                                    'IP: ${controller.lstDVR[index].ip}\nPassword: ${controller.lstDVR[index].password}\nChannel: ${controller.lstDVR[index].channel}\n',
                                                                    style: GoogleFonts.bebasNeue(
                                                                        fontSize:
                                                                            25,
                                                                        color: Colors
                                                                            .grey[500]),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                width: 30,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        dvrdetailbloc.index =
                                                                            index;
                                                                        host.text = controller
                                                                            .lstDVR[index]
                                                                            .host!;
                                                                        ip.text = controller
                                                                            .lstDVR[index]
                                                                            .ip!;
                                                                        channel.text = controller
                                                                            .lstDVR[index]
                                                                            .channel!;
                                                                        pass.text = controller
                                                                            .lstDVR[index]
                                                                            .password!;
                                                                        name.text = controller
                                                                            .lstDVR[index]
                                                                            .name
                                                                            .toString();
                                                                        update_dvr(
                                                                            context,
                                                                            host,
                                                                            ip,
                                                                            channel,
                                                                            pass,
                                                                            dvrdetailbloc,
                                                                            controller.lstDVR[index].id!,
                                                                            name);
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .edit,
                                                                        size:
                                                                            30,
                                                                      )),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      dvrdetailbloc
                                                                              .index =
                                                                          index;
                                                                      host.text = controller
                                                                          .lstDVR[
                                                                              index]
                                                                          .host!;
                                                                      ip.text = controller
                                                                          .lstDVR[
                                                                              index]
                                                                          .ip!;
                                                                      channel.text = controller
                                                                          .lstDVR[
                                                                              index]
                                                                          .channel!;
                                                                      pass.text = controller
                                                                          .lstDVR[
                                                                              index]
                                                                          .password!;
                                                                      name.text = controller
                                                                          .lstDVR[
                                                                              index]
                                                                          .name!;
                                                                      delete_dvr(
                                                                          context,
                                                                          host,
                                                                          ip,
                                                                          channel,
                                                                          pass,
                                                                          dvrdetailbloc,
                                                                          controller
                                                                              .lstDVR[index]
                                                                              .id!,
                                                                          name);
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .delete,
                                                                      size: 30,
                                                                    ),
                                                                    color: Colors
                                                                        .redAccent,
                                                                  ),
                                                                ],
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  )))),
                            );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.30,
                          ),
                          const Center(child: CircularProgressIndicator()),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text('No Data'));
                    }
                  })))
        ],
      ),
    );
  }
}
