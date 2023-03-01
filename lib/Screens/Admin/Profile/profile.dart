// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(slivers: [
        appbar(),
        SliverToBoxAdapter(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: containerColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: const Offset(0, 7),
                          spreadRadius: 3,
                          blurRadius: 7)
                    ]),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.person_outlined,
                      size: 60,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        large_text("Admin12"),
                        text_medium("Admin12@gmail.com"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: containerColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: const Offset(0, 7),
                          spreadRadius: 3,
                          blurRadius: 7)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => context.go("/AddUser"),
                        child: profile_list_tile(
                            context, "Add User", CupertinoIcons.add_circled),
                      ),
                      const Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      profile_list_tile(
                          context, "Setting", CupertinoIcons.settings),
                      const Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      InkWell(
                        onTap: () => context.go(routesAssignCourse),
                        child: profile_list_tile(context, "Assign Courses",
                            Icons.assignment_turned_in_outlined),
                      ),
                      const Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      profile_list_tile(context, "FAQ's", Icons.assignment),
                      const Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      profile_list_tile(context, "Log Out", Icons.logout),
                    ],
                  ),
                ),
              ),
            )
          ],
        ))
      ]),
    );
  }

  ListTile profile_list_tile(BuildContext context, String text, IconData icon) {
    return ListTile(
        leading: Icon(icon),
        title: text_medium(text),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.green,
        ));
  }

  SliverAppBar appbar() {
    return SliverAppBar(
      foregroundColor: shadowColorDark,
      backgroundColor: backgroundColor,
      snap: false,
      pinned: true,
      automaticallyImplyLeading: false,
      floating: false,
      title: Text(
        "Profile",
        style: GoogleFonts.poppins(
            fontSize: MediumFontSize.toDouble(), color: shadowColorDark),
      ),
      elevation: 0,
    );
  }
}
