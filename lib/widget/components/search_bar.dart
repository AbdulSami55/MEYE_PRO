import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/constants.dart';

SliverToBoxAdapter searchBar({required bool isTeacher}) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
      child: CupertinoSearchTextField(
        style: const TextStyle(
          color: Colors.black,
        ),
        onChanged: (value) {
          // SearchMutation(value);
        },
        decoration: BoxDecoration(
          color: backgroundColorLight,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );
}
