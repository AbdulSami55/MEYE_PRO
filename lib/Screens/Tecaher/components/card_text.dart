import 'package:flutter/cupertino.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/textcomponents/small_text.dart';

Row cardText(String title, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(
        width: 5,
      ),
      text_medium(title, color: shadowColorDark),
      textSmall(text, color: backgroundColorDark)
    ],
  );
}
