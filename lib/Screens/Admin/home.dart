// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/live_stream_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:provider/provider.dart';
import 'DVR/add_dvr.dart';
import 'package:go_router/go_router.dart';

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
      body: CustomScrollView(
        slivers: [
          appbar("Live Stream",
              automaticallyImplyLeading: false,
              backgroundColor: backgroundColor),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
              create: (_) => LiveStreamViewModel(),
              child: Consumer<LiveStreamViewModel>(
                  builder: ((context, provider, child) {
                return _ui(provider, context);
              })),
            ),
          ),
        ],
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

  _ui(LiveStreamViewModel provider, BuildContext context) {
    if (provider.loading) {
      return apploading(context);
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
            children: provider.vlcPlayer
                .asMap()
                .map((index, e) =>
                    MapEntry(index, cameraView(context, e, index)))
                .values
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget cameraView(BuildContext context,
      VlcPlayerController vlcPlayerController, int index) {
    return InkWell(
      onTap: () {
        context.read<LiveStreamViewModel>().selectedVideo = index;
        context.push(routesLiveStreamDetails);
      },
      child: Stack(
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
                  controller: vlcPlayerController,
                  aspectRatio: 16 / 9,
                  placeholder: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 10,
              left: 20,
              child: large_text("Lab${index + 1}", color: primaryColor))
        ],
      ),
    );
  }
}
