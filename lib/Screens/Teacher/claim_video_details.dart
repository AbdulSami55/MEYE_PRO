// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Teacher/claim_teacher.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ClaimVideoDetails extends StatelessWidget {
  ClaimVideoDetails({super.key, required this.provider});
  TeacherCHRViewModel provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Video", bgColor: backgroundColorLight),
          videoScreen(context),
          videoList()
        ],
      ),
    );
  }

  SliverToBoxAdapter videoList() {
    return SliverToBoxAdapter(
      child: ChangeNotifierProvider.value(
          value: provider,
          child: Consumer<TeacherCHRViewModel>(
              builder: (context, provider, child) {
            return Container(
              color: backgroundColorLight,
              child: Column(
                children: [
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.lstClaim.length,
                      itemBuilder: ((context, index) {
                        ClaimTeacher teacherRecordings =
                            provider.tempTeacherClaimVideo[index];
                        String time = teacherRecordings.thumbnail
                            .toString()
                            .split('/')[4]
                            .split('.')[0];
                        return teacherRecordings != provider.selectedVideo
                            ? Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      provider.setPlayer(
                                          '$getvideo${teacherRecordings.file}');
                                      provider
                                          .setSelectedVideo(teacherRecordings);
                                    },
                                    child: ListTile(
                                      leading: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          '$getClaimVideoThumbnialurl${teacherRecordings.thumbnail}',
                                        ),
                                      ),
                                      title: text_medium(
                                          "${teacherRecordings.folder}"),
                                      subtitle: Text(
                                          "${time.split(',')[0].replaceAll(' ', ':')}-${time.split(',')[1].replaceAll(' ', ':')}"),
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
          value: provider,
          child: Consumer<TeacherCHRViewModel>(
            builder: (context, provider, child) {
              if (!provider.isloading) {
                String time = provider.selectedVideo.thumbnail
                    .toString()
                    .split('/')[4]
                    .split('.')[0];
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
                            large_text(
                                provider.selectedVideo.folder.toString()),
                            large_text("   "),
                            text_medium(
                                "${time.split(',')[0].replaceAll(' ', ':')}-${time.split(',')[1].replaceAll(' ', ':')}")
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
