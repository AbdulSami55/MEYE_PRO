import 'package:flutter/cupertino.dart';
import 'package:live_streaming/widget/components/apploading.dart';

Column loadingBar(BuildContext context) {
  return Column(
    children: [
      appShimmer(MediaQuery.of(context).size.width * 0.95, 100),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: appShimmer(MediaQuery.of(context).size.width * 0.95, 100),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: appShimmer(MediaQuery.of(context).size.width * 0.95, 100),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: appShimmer(MediaQuery.of(context).size.width * 0.95, 100),
      ),
    ],
  );
}
