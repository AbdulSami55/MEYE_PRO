// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';

import '../utilities/constants.dart';

Padding Teachertopcard(BuildContext context, String image, String name,
    bool isrecording, dynamic onpress) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.15,
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
            child:
                CircleAvatar(radius: 33, backgroundImage: NetworkImage(image)),
          ),
          const SizedBox(
            width: 5,
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  text_medium("Name="),
                  text_medium(name, color: shadowColorLight),
                  const SizedBox(
                    width: 40,
                  ),
                  isrecording
                      ? InkWell(onTap: onpress, child: const Icon(Icons.sort))
                      : const Text("")
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
