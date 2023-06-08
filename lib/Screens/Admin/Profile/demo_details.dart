// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/demo.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/demo_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class DemoDetailsScreen extends StatelessWidget {
  DemoDetailsScreen({super.key, required this.demo, required this.provider});
  Demo demo;
  DemoViewModel provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Demo Video Details", bgColor: backgroundColorLight),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider.value(
                value: provider,
                child: Consumer<DemoViewModel>(
                  builder: (context, provider, child) =>
                      _ui(provider, context, demo),
                )),
          ),
        ],
      ),
    );
  }

  _ui(DemoViewModel demoViewModel, BuildContext context, Demo demo) {
    if (demoViewModel.isloading) {
      return apploading(context);
    }
    if (demoViewModel.userError != null) {
      return ErrorMessage(demoViewModel.userError!.message.toString());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
                '$baseUrl/api/demothumbnail?file=${demo.thumbnail}'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: text_medium(
              "Total Time In=${demoViewModel.demoDetails!.totalTimeIn}"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: text_medium(
              "Total Time Out=${demoViewModel.demoDetails!.totalTimeOut}"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: text_medium("Sit=${demoViewModel.demoDetails!.sitMin}"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: text_medium("Stand=${demoViewModel.demoDetails!.standMin}"),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 12.0),
        //   child:
        //       text_medium("Sit=${demoViewModel.demoDetails!.sit.toInt()} Sec"),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 12.0),
        //   child: text_medium(
        //       "Stand=${demoViewModel.demoDetails!.stand.toInt()} Sec"),
        // )
      ],
    );
  }
}
