// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Bloc/CameraDetailsBloc.dart';
import 'package:live_streaming/Model/Admin/Camera/Camera.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:live_streaming/widget/Camera/update_camera.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../Store/Admin/CameraDetails.dart';
import '../../../widget/Camera/delete_camera.dart';

class CameraDetails extends StatefulWidget {
  const CameraDetails({super.key});

  @override
  State<CameraDetails> createState() => _CameraDetailsState();
}

class _CameraDetailsState extends State<CameraDetails> {
  final cameradetailbloc = CameraDetailsBloc();
  final ScrollController scrollcontroller = ScrollController();
  @override
  void initState() {
    cameradetailbloc.eventsinkCameraDetails.add(CameraDetailsAction.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = (VxState.store as MyStore);
    TextEditingController ip = TextEditingController();
    TextEditingController lt = TextEditingController();
    TextEditingController no = TextEditingController();
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.grey[850],
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
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          SearchMutation(value);
                        },
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
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
              "Camera Details",
              style: GoogleFonts.poppins(fontSize: 30),
            ),
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: StreamBuilder<List<Camera>>(
                stream: cameradetailbloc.streamCameraDetails,
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
                        : Container(
                            child: VxBuilder(
                                mutations: const {SearchMutation},
                                builder: ((context, stor, status) =>
                                    ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: store.lstcamera!.length,
                                        itemBuilder: ((context, index) =>
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.all(
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
                                                      const CircleAvatar(
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_rounded,
                                                          size: 30,
                                                        ),
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
                                                            'Room Name: ${store.lstcamera![index].lt}',
                                                            style: GoogleFonts
                                                                .bebasNeue(
                                                                    fontSize:
                                                                        25),
                                                          ),
                                                          Text(
                                                            'Camera Ip: ${store.lstcamera![index].ip}\nCamera Number: ${store.lstcamera![index].no}\n',
                                                            style: GoogleFonts
                                                                .bebasNeue(
                                                                    fontSize:
                                                                        25,
                                                                    color: Colors
                                                                            .grey[
                                                                        500]),
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
                                                                cameradetailbloc
                                                                        .index =
                                                                    index;
                                                                lt.text = store
                                                                    .lstcamera![
                                                                        index]
                                                                    .lt;
                                                                ip.text = store
                                                                    .lstcamera![
                                                                        index]
                                                                    .ip;
                                                                no.text = store
                                                                    .lstcamera![
                                                                        index]
                                                                    .no;
                                                                update_camera(
                                                                    context,
                                                                    lt,
                                                                    ip,
                                                                    no,
                                                                    cameradetailbloc);
                                                              },
                                                              icon: const Icon(
                                                                Icons.edit,
                                                                size: 30,
                                                              )),
                                                          IconButton(
                                                            onPressed: () {
                                                              cameradetailbloc
                                                                      .index =
                                                                  index;
                                                              lt.text = store
                                                                  .lstcamera![
                                                                      index]
                                                                  .lt;
                                                              ip.text = store
                                                                  .lstcamera![
                                                                      index]
                                                                  .ip;
                                                              no.text = store
                                                                  .lstcamera![
                                                                      index]
                                                                  .no;
                                                              delete_camera(
                                                                  context,
                                                                  lt,
                                                                  ip,
                                                                  no,
                                                                  cameradetailbloc);
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              size: 30,
                                                            ),
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                        ],
                                                      ),
                                                    ]),
                                              ),
                                            ))))),
                          );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child: Text('No Data'));
                  }
                })),
          )
        ],
      ),
    );
  }
}
