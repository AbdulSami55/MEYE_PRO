import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Screens/Tecaher/components/card_text.dart';
import 'package:live_streaming/Screens/Tecaher/components/loading_bar.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/view_models/signin_view_model.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class TeacherCHRScreen extends StatelessWidget {
  const TeacherCHRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignInViewModel>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          stdteacherappbar(context, isteacher: true),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
                create: (_) =>
                    TeacherCHRViewModel(provider.user.name.toString()),
                child: Consumer<TeacherCHRViewModel>(
                    builder: ((context, value, child) => _ui(context, value)))),
          )
        ],
      ),
    );
  }

  Widget _ui(BuildContext context, TeacherCHRViewModel provider) {
    if (provider.isloading) {
      return loadingBar(context);
    } else if (provider.userError != null) {
      return ErrorMessage(provider.userError!.message.toString());
    }
    return mainPage(context, provider);
  }

  Widget mainPage(BuildContext context, TeacherCHRViewModel provider) {
    return provider.lstTeacherChr.isEmpty
        ? Center(
            child: large_text("No Report"),
          )
        : ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: provider.lstTeacherChr.length,
            itemBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      provider.selectedIndex = index;
                      provider.setIsTeacherChr();
                      context.push(routesTeacherChrDetailsScreen,
                          extra: provider);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 7),
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7)
                          ],
                          color:
                              provider.lstTeacherChr[index].status == 'Not Held'
                                  ? Colors.redAccent
                                  : containerColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                text_medium(
                                    provider.lstTeacherChr[index].status)
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(
                                color: shadowColorDark,
                              ),
                            ),
                            cardText(
                                'Date: ', provider.lstTeacherChr[index].date),
                            const SizedBox(
                              height: 10,
                            ),
                            cardText('Course: ',
                                provider.lstTeacherChr[index].courseName),
                            const SizedBox(
                              height: 10,
                            ),
                            cardText('Discipline: ',
                                provider.lstTeacherChr[index].discipline),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
