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
      body: CustomScrollView(
        slivers: [
          stdteacherappbar(context),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [containerCardColor, Colors.red]),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: ((context) => TeachViewModel(1, context)),
                    child: Consumer<TeachViewModel>(
                        builder: (context, provider, child) {
                      return ScheduleTable(
                          context, provider, timetableViewModel,
                          iswhite: true);
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
