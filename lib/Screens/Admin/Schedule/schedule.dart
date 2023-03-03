import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/view_models/Admin/User/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utilities/constants.dart';
import '../Teacher/teacher_details.dart';

class RescheduleScreen extends StatelessWidget {
  const RescheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: false,
            snap: true,
            pinned: true,
            floating: true,
            title: Row(
              children: [
                Text(
                  "Schedule",
                  style:
                      GoogleFonts.poppins(fontSize: 30, color: shadowColorDark),
                ),
              ],
            ),
            elevation: 0,
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () => userViewModel.refreshPage(),
          child: TeacherDetails(
            isSchedule: true,
          ),
        ),
      ),
    );
  }
}
