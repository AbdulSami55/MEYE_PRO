// ignore_for_file: unused_field, unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:provider/provider.dart';
import '../../view_models/handle_bottom_nav.dart';
import 'DVR/dvr_details.dart';
import 'Profile/profile.dart';
import 'Schedule/schedule.dart';
import 'home.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BottomNavViewModel>();
    final List screens = [
      Home(),
      const DVRDetails(),
      const RescheduleScreen(),
      const Profile()
    ];
    return Scaffold(
        backgroundColor: backgroundColor,
        body: screens[provider.adminSelectedValue],
        bottomNavigationBar: Transform.translate(
          offset: const Offset(0, 10),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 12, top: 12, right: 12, bottom: 12),
              margin: const EdgeInsets.only(left: 24, bottom: 20, right: 24),
              decoration: BoxDecoration(
                color: backgroundColor2.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: backgroundColor2.withOpacity(0.3),
                    offset: const Offset(0, 20),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      provider.setAdminSelectValue(0);
                    },
                    child: Opacity(
                        opacity: provider.adminSelectedValue == 0 ? 1 : 0.5,
                        child: bottomIcon(CupertinoIcons.home)),
                  ),
                  InkWell(
                    onTap: () {
                      provider.setAdminSelectValue(1);
                    },
                    child: Opacity(
                        opacity: provider.adminSelectedValue == 1 ? 1 : 0.5,
                        child: bottomIcon(Icons.camera)),
                  ),
                  InkWell(
                    onTap: () {
                      provider.setAdminSelectValue(2);
                    },
                    child: Opacity(
                        opacity: provider.adminSelectedValue == 2 ? 1 : 0.5,
                        child: bottomIcon(Icons.grid_view)),
                  ),
                  InkWell(
                    onTap: () {
                      provider.setAdminSelectValue(3);
                    },
                    child: Opacity(
                        opacity: provider.adminSelectedValue == 3 ? 1 : 0.5,
                        child: bottomIcon(Icons.account_circle_sharp)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  SizedBox bottomIcon(IconData iconData) {
    return SizedBox(
        height: 36,
        width: 36,
        child: Icon(
          iconData,
          color: containerColor,
        ));
  }
}
