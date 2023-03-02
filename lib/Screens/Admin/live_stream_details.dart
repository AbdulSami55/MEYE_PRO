import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

import '../../utilities/constants.dart';
import '../../view_models/Admin/live_stream_view_model.dart';
import '../../widget/components/apploading.dart';
import '../../widget/textcomponents/large_text.dart';

class LiveStreamingDetails extends StatelessWidget {
  const LiveStreamingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar(
            "Live Stream Details",
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
              create: (context) => LiveStreamViewModel(),
              child: Consumer<LiveStreamViewModel>(
                  builder: ((context, provider, child) {
                return _ui(provider, context);
              })),
            ),
          ),
        ],
      ),
    );
  }

  _ui(LiveStreamViewModel provider, BuildContext context) {
    if (provider.loading) {
      return apploading();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          cameraView(context, provider),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: containerColor,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 7),
                        color: Colors.grey.withOpacity(0.5))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        text_medium("Bscs-8B"),
                        text_medium("Mr Umer"),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        text_medium("PDC"),
                        text_medium("08-30-10:00"),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        text_medium("LAB5"),
                        text_medium("Camera-02"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cameraView(BuildContext context, LiveStreamViewModel provider) {
    return InkWell(
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
                  controller: provider.vlcPlayer,
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
      ),
    );
  }
}
