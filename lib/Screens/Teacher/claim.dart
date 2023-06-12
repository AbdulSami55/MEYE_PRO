// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:live_streaming/Screens/Teacher/claim_video_details.dart';
import 'package:live_streaming/Screens/Teacher/components/loading_bar.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:provider/provider.dart';

import '../../widget/textcomponents/medium_text.dart';

class ClaimScreen extends StatelessWidget {
  ClaimScreen({super.key, required this.provider});
  TeacherCHRViewModel provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          stdteacherappbar(context, isteacher: true, isback: true),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider.value(
                value: provider,
                child: Consumer<TeacherCHRViewModel>(
                    builder: ((context, value, child) {
                  return _ui(context, value);
                }))),
          )
        ],
      ),
    );
  }

  Widget _ui(BuildContext context, TeacherCHRViewModel provider) {
    if (provider.isloading) {
      return loadingBar(context);
    } else if (provider.userError != null) {
      return ErrorMessage(provider.userError!.message.toString());
    }
    return mainPage(context, provider);
  }

  Widget mainPage(BuildContext context, TeacherCHRViewModel provider) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: provider.lstClaim.length,
        itemBuilder: (context, index) {
          String time = provider.lstClaim[index].thumbnail
              .toString()
              .split('/')[4]
              .split('.')[0];
          return InkWell(
            onTap: () {
              provider.setSelectedVideo(provider.lstClaim[index]);
              provider.setPlayer('$getvideo${provider.lstClaim[index].file!}');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ClaimVideoDetails(provider: provider)));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                        '$getClaimVideoThumbnialurl${provider.lstClaim[index].thumbnail}'),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, bottom: 8.0, top: 8.0),
                      child: large_text(
                          provider.lstClaim[index].folder.toString()),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: text_medium(
                            "${time.split(',')[0].replaceAll(' ', ':')}-${time.split(',')[1].replaceAll(' ', ':')}"))
                  ],
                ),
              ],
            ),
          );
        });
  }
}
