import 'package:flutter/material.dart';
import 'package:live_streaming/Screens/onboding/components/sign_in_form.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/User/user_view_model.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/view_models/signin_view_model.dart';
import 'package:live_streaming/widget/components/schedule.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:provider/provider.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignInViewModel>();
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          stdteacherappbar(context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ChangeNotifierProvider(
                  create: ((context) =>
                      TimetableViewModel(provider.user.name.toString())),
                  child: Consumer<TimetableViewModel>(
                      builder: (context, provider, child) {
                    return ScheduleTable(context, provider);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
