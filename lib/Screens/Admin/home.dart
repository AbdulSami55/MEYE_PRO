// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Model/Admin/ip.dart';
import 'package:live_streaming/utilities/constants.dart';

import 'DVR/add_dvr.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController ip = TextEditingController();
  TextEditingController host = TextEditingController();
  TextEditingController channel = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Row(
          children: [
            Text(
              'Live Stream',
              style: GoogleFonts.poppins(fontSize: 25, color: shadowColorDark),
            ),
          ],
        ),
      ),
      body: NetworkIP.lst.isEmpty
          ? Center(
              child: Text(
              "No Camera Availible",
              style: GoogleFonts.bebasNeue(fontSize: 30),
            ))
          : SingleChildScrollView(
              child: Column(children: [
                Wrap(
                    direction: Axis.horizontal,
                    children: NetworkIP.lst
                        .map((element) => StreamBuilder(
                              stream: element,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.42,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.20,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.green,
                                                  width: 2),
                                            ),
                                            child: Image.memory(
                                              snapshot.data,
                                              gaplessPlayback: true,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const Positioned(
                                              left: 10,
                                              right: 20,
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return const Text(" Camera  Not  Availible");
                                }
                              },
                            ))
                        .toList()),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.00,
                // )
              ]),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          add_dvr(context, host, ip, channel, pass, name);
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
