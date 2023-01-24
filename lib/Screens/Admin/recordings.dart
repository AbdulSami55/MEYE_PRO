// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/teacherrecordings.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:video_player/video_player.dart';

import '../../utilities/constants.dart';
import '../../widget/components/appbar.dart';
import '../../widget/textcomponents/medium_text.dart';

class VideoPlay extends StatefulWidget {
  VideoPlay(
      {Key? key,
      required this.index,
      required this.user,
      required this.teacherRecordings})
      : super(key: key);
  int index;
  User user;
  TeacherRecordings teacherRecordings;
  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
        'http://192.168.43.192:8000/video?path=${widget.teacherRecordings.recordings![widget.index].filename}');
    _initializeVideoPlayerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar("Video"),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Teachertopcard(
                    context,
                    "$getuserimage${widget.user.role}/${widget.user.image}",
                    widget.user.name.toString(),
                    false,
                    widget.teacherRecordings,
                    widget.index),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VideoPlayer(controller),
                        ),
                        Text(
                            "Total Duration: ${controller.value.duration.toString().split('.')[0]}"),
                        VideoProgressIndicator(controller,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                              backgroundColor: containerColor,
                              playedColor: shadowColorLight,
                              bufferedColor: Colors.grey,
                            )),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (controller.value.isPlaying) {
                                    controller.pause();
                                  } else {
                                    controller.play();
                                  }

                                  setState(() {});
                                },
                                icon: Icon(controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow)),
                            IconButton(
                                onPressed: () {
                                  controller.seekTo(const Duration(seconds: 0));

                                  setState(() {});
                                },
                                icon: const Icon(Icons.stop))
                          ],
                        ),
                      ]);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding Teachertopcard(BuildContext context, String image, String name,
      bool isrecording, TeacherRecordings teacherRecordings, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: backgroundColorLight,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 7),
                  color: Colors.grey.withOpacity(0.5))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  radius: 33, backgroundImage: NetworkImage(image)),
            ),
            const SizedBox(
              width: 5,
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    text_medium("Name="),
                    text_medium(name, color: shadowColorLight),
                  ],
                ),
                Row(
                  children: [
                    text_medium("Course="),
                    text_medium(
                        teacherRecordings.course![index].name.toString(),
                        color: shadowColorLight),
                  ],
                ),
                Row(
                  children: [
                    text_medium("Section="),
                    text_medium(
                        teacherRecordings.section![index].name.toString(),
                        color: shadowColorLight),
                  ],
                ),
                Row(
                  children: [
                    text_medium("Type="),
                    text_medium(
                        teacherRecordings.recordings![index].filename
                            .split(',')[2]
                            .toString()
                            .split('.')[0],
                        color: shadowColorLight),
                  ],
                ),
                Row(
                  children: [
                    text_medium("Date="),
                    text_medium(
                        teacherRecordings.recordings![index].date
                            .toString()
                            .split(' ')[0],
                        color: shadowColorLight),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
