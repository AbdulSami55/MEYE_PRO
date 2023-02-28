// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Model/Admin/ip.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/recording_view_model.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

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
      body: Consumer<RecordingViewModel>(builder: ((context, provider, child) {
        if (provider.loading) {
          return apploading();
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSearchTextField(
                  decoration: BoxDecoration(
                    color: backgroundColorLight,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  cameraView(context, provider),
                  cameraView(context, provider),
                  cameraView(context, provider),
                  cameraView(context, provider),
                ],
              ),
            ],
          ),
        );
      })),
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

  Widget cameraView(BuildContext context, RecordingViewModel provider) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 7),
                      color: Colors.grey.withOpacity(0.5))
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: VlcPlayer(
                controller: provider.vlcPlayer!,
                aspectRatio: 16 / 9,
                placeholder: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 10, left: 20, child: large_text("Lab5", color: primaryColor))
      ],
    );
  }
}
