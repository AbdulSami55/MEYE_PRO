import 'package:flutter/material.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';

Row topBar(BuildContext context, String image, String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: text_medium(name.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: image == ""
            ? const CircleAvatar(
                radius: 33,
                backgroundImage:
                    AssetImage("assets/avaters/Avatar Default.jpg"))
            : CircleAvatar(radius: 33, backgroundImage: NetworkImage(image)),
      ),
    ],
  );
}
