import 'package:flutter/material.dart';
import 'package:live_streaming/Screens/Admin/Profile/demo_details.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/demo_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Demo", bgColor: backgroundColorLight),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
                create: (_) => DemoViewModel(),
                child: Consumer<DemoViewModel>(
                  builder: (context, provider, child) => _ui(provider, context),
                )),
          ),
        ],
      ),
    );
  }

  _ui(DemoViewModel demoViewModel, BuildContext context) {
    if (demoViewModel.isloading) {
      return apploading(context);
    }
    if (demoViewModel.userError != null) {
      return ErrorMessage(demoViewModel.userError!.message.toString());
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: demoViewModel.lstDemo.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  demoViewModel
                      .getDemoVideoDetails(demoViewModel.lstDemo[index].file);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DemoDetailsScreen(
                                demo: demoViewModel.lstDemo[index],
                                provider: demoViewModel,
                              )));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                            '$baseUrl/api/demothumbnail?file=${demoViewModel.lstDemo[index].thumbnail}'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: text_medium(
                          demoViewModel.lstDemo[index].thumbnail.split('.')[0]),
                    )
                  ],
                ),
              ),
            ));
  }
}
