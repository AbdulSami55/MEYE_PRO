import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Screens/Student/components/text.dart';
import 'package:live_streaming/Screens/Student/notification.dart';
import 'package:live_streaming/view_models/Student/notification_view_model.dart';
import 'package:live_streaming/view_models/signin_view_model.dart';
import 'package:provider/provider.dart';
import '../../utilities/constants.dart';

SliverAppBar stdteacherappbar(BuildContext context,
    {bool isteacher = false, bool? isback, Color? appBarColor}) {
  final provider = context.watch<SignInViewModel>();
  return SliverAppBar(
    backgroundColor: appBarColor ?? backgroundColorLight,
    pinned: true,
    foregroundColor:
        appBarColor != null ? backgroundColorLight : shadowColorDark,
    actions: [
      Column(
        children: [
          const SizedBox(
            height: 13,
          ),
          InkWell(
            onTap: () {
              if (provider.user.role == 'Student') {
                context
                    .read<StudentNotificationViewModel>()
                    .getStudentNotification(provider.user.userID.toString());
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const StudentNotificationScreen()));
            },
            child: const badges.Badge(
              badgeContent: Text(
                "1",
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(
                Icons.notifications,
                color: Colors.amber,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        width: 15,
      ),
      InkWell(
        onTap: () {
          provider.stopAPIRequests();
          User user = User();
          provider.setUser(user);
          context.go(routesSignin);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 2),
          child: provider.user.image == ""
              ? const CircleAvatar(
                  radius: 33,
                  backgroundImage:
                      AssetImage("assets/avaters/Avatar Default.jpg"))
              : CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      "$getuserimage${provider.user.role}/${provider.user.image}")),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
    automaticallyImplyLeading: isback ?? false,
    title: student_text(
        context,
        isteacher
            ? provider.user.name!.split(' ')[0] == "Dr."
                ? "${provider.user.name}"
                : "Mr ${provider.user.name}"
            : "${provider.user.name}",
        30,
        color: appBarColor != null ? backgroundColorLight : shadowColorDark),
  );
}
