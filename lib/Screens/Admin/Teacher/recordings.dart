// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/recordings.dart';
import 'package:live_streaming/view_models/Admin/User/teacherrecordings_view_model.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../utilities/constants.dart';
import '../../../widget/components/appbar.dart';
import '../../../widget/textcomponents/medium_text.dart';

class VideoPlay extends StatelessWidget {
  VideoPlay({Key? key, required this.teacherRecordingsViewModel})
      : super(key: key);
  TeacherRecordingsViewModel teacherRecordingsViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Video", backgroundColor: backgroundColorLight),
          videoScreen(context),
          videoList()
        ],
      ),
    );
  }

  SliverToBoxAdapter videoList() {
    return SliverToBoxAdapter(
      child: ChangeNotifierProvider.value(
          value: teacherRecordingsViewModel,
          child: Consumer<TeacherRecordingsViewModel>(
              builder: (context, provider, child) {
            return Container(
              color: backgroundColorLight,
              child: Column(
                children: [
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: teacherRecordingsViewModel
                          .tempTeacherRecordings.length,
                      itemBuilder: ((context, index) {
                        Recordings teacherRecordings =
                            teacherRecordingsViewModel
                                .tempTeacherRecordings[index];

                        return teacherRecordings !=
                                teacherRecordingsViewModel.selectedVideo
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      teacherRecordingsViewModel.setPlayer(
                                          '$getvideo${teacherRecordings.fileName}');
                                      teacherRecordingsViewModel
                                          .setSelectedVideo(teacherRecordings);
                                    },
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.play_arrow,
                                        color: primaryColor,
                                        size: 50,
                                      ),
                                      title: text_medium(
                                          "${teacherRecordings.date.toString().split(' ')[0]}\n${teacherRecordings.fileName.split(',')[2]}"),
                                      subtitle: Text(
                                          "${teacherRecordings.courseName}\n${teacherRecordings.discipline}"),
                                    ),
                                  ),
                                  const Divider()
                                ],
                              )
                            : const Padding(padding: EdgeInsets.zero);
                      })),
                ],
              ),
            );
          })),
    );
  }

  SliverAppBar videoScreen(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: false,
      elevation: 0,
      backgroundColor: backgroundColorLight,
      expandedHeight: MediaQuery.of(context).size.height > 500
          ? MediaQuery.of(context).size.height * 0.3
          : MediaQuery.of(context).size.height * 0.4,
      collapsedHeight: MediaQuery.of(context).size.height > 500
          ? MediaQuery.of(context).size.height * 0.3
          : MediaQuery.of(context).size.height * 0.4,
      flexibleSpace: FlexibleSpaceBar(
        background: ChangeNotifierProvider.value(
          value: teacherRecordingsViewModel,
          child: Consumer<TeacherRecordingsViewModel>(
            builder: (context, provider, child) {
              if (!provider.loading) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              provider.setIsShow();
                            },
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: VideoPlayer(provider.videoController),
                            ),
                          ),
                          provider.isshow
                              ? Positioned(
                                  top: 50,
                                  left: 65,
                                  right: 75,
                                  child: IconButton(
                                      onPressed: () {
                                        if (provider
                                            .videoController.value.isPlaying) {
                                          provider.videoController.pause();
                                        } else {
                                          provider.videoController.play();
                                        }
                                        provider.setloading(false);
                                      },
                                      icon: Icon(
                                        provider.videoController.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 50,
                                      )),
                                )
                              : const Text(""),
                          // provider.isshow
                          //     ? Positioned(
                          //         bottom: 10,
                          //         child: text_medium(provider.time,
                          //             color: Colors.white))
                          //     : const Padding(padding: EdgeInsets.zero),
                          provider.isshow
                              ? Positioned(
                                  bottom: 2,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.99,
                                    height: 9,
                                    child: VideoProgressIndicator(
                                        provider.videoController,
                                        allowScrubbing: true,
                                        colors: const VideoProgressColors(
                                          backgroundColor: containerColor,
                                          playedColor: shadowColorLight,
                                          bufferedColor: Colors.grey,
                                        )),
                                  ),
                                )
                              : const Text("")
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            large_text(provider.selectedVideo.courseName),
                            large_text("   "),
                            large_text(provider.selectedVideo.fileName
                                .split(',')[2]
                                .split('.')[0])
                          ],
                        ),
                      )
                    ]);
              } else {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      height: MediaQuery.of(context).size.height * 0.28,
                      decoration: const BoxDecoration(color: Colors.black),
                    ),
                    const Positioned(
                        top: 80,
                        left: 65,
                        right: 75,
                        child: SizedBox(
                          width: 10,
                          height: 35,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ))
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
