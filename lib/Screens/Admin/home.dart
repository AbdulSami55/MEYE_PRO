// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Model/Admin/ip.dart';

import '../../widget/DVR/add_dvr.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController ip = TextEditingController();
  TextEditingController host = TextEditingController();
  TextEditingController channel = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Live Stream',
          style: GoogleFonts.poppins(fontSize: 25),
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
                StreamBuilder(
                  stream: NetworkIP.lst[0],
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        color: Colors.green,
                        child: Stack(
                          children: [
                            Image.memory(
                              snapshot.data,
                              gaplessPlayback: true,
                              height: MediaQuery.of(context).size.height * 0.60,
                              fit: BoxFit.cover,
                            ),
                            const Positioned(
                                left: 10,
                                right: 20,
                                child: Text(
                                  "Cam 01",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Text("Camera 01 Not  Availible");
                    }
                  },
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: NetworkIP.lst.length - 1,
                      itemBuilder: ((context, index) {
                        return StreamBuilder(
                          stream: NetworkIP.lst[index + 1],
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return InkWell(
                                onTap: () {
                                  final cam = NetworkIP.lst[0];
                                  NetworkIP.lst[0] = NetworkIP.lst[index + 1];
                                  NetworkIP.lst[index + 1] = cam;
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 2),
                                  ),
                                  child: Stack(
                                    children: [
                                      Image.memory(
                                        snapshot.data,
                                        gaplessPlayback: true,
                                      ),
                                      Positioned(
                                          left: 10,
                                          right: 20,
                                          child: Text(
                                            "Cam 0${index + 2}",
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
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
                              return Text(
                                  " Camera 0${index + 2} Not  Availible");
                            }
                          },
                        );
                      })),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.00,
                // )
              ]),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        onPressed: () {
          add_dvr(context, host, ip, channel, pass);
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
