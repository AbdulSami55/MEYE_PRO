import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Screens/Student/components/text.dart';

import '../../utilities/constants.dart';

SliverAppBar stdteacherappbar(BuildContext context) {
  return SliverAppBar(
    pinned: true,
    actions: [
      Column(
        children: const [
          SizedBox(
            height: 13,
          ),
          badges.Badge(
            badgeContent: Text(
              "2",
              style: TextStyle(color: Colors.white),
            ),
            child: Icon(
              Icons.notifications,
              color: Colors.amber,
              size: 30,
            ),
          ),
        ],
      ),
      const SizedBox(
        width: 15,
      ),
      InkWell(
        onTap: () => context.go(routesSignin),
        child: const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 2),
          child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/avaters/Avatar 2.jpg")),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
    automaticallyImplyLeading: false,
    title: student_text(context, "Abdul Sami", 30, color: containerColor),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              containerCardColor,
              Color.fromARGB(255, 141, 114, 238)
            ]),
      ),
    ),
  );
}
