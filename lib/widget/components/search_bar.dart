import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/User/user_view_model.dart';

SliverToBoxAdapter searchBar(
    {required bool isTeacher, UserViewModel? userViewModel}) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
      child: CupertinoSearchTextField(
        style: const TextStyle(
          color: Colors.black,
        ),
        onChanged: (value) {
          if (isTeacher) {
            userViewModel!.searchUser(value);
          }
        },
        decoration: BoxDecoration(
          color: backgroundColorLight,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );
}
