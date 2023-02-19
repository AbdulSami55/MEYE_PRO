import 'package:flutter/material.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:provider/provider.dart';

import '../../utilities/constants.dart';
import '../../view_models/Admin/teach_view_model.dart';
import '../../view_models/Admin/timetable.dart';
import '../../widget/components/schedule.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final timetableViewModel = context.watch<TimetableViewModel>();
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          std_teacher_appbar(context),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
              create: ((context) => TeachViewModel(1, context)),
              child: Container(
                color: backgroundColorLight,
                child: Consumer<TeachViewModel>(
                    builder: (context, provider, child) {
                  return ScheduleTable(context, provider, timetableViewModel);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
