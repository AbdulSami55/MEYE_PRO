import 'package:flutter/cupertino.dart';
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

class DirectorDashboardScreen extends StatelessWidget {
  const DirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          stdteacherappbar(context, isteacher: true),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
                create: (_) => TeacherCHRViewModel('', isDirector: true),
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
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: containerColor,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => provider.setSelectedTab(0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            color: provider.selectedTab == 0
                                ? primaryColor
                                : containerColor,
                            height: 50,
                            child: Center(
                                child: text_medium("Home",
                                    color: provider.selectedTab == 0
                                        ? backgroundColorLight
                                        : shadowColorDark,
                                    font: 20)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => provider.setSelectedTab(1),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            color: provider.selectedTab == 1
                                ? primaryColor
                                : containerColor,
                            height: 50,
                            child: Center(
                                child: text_medium("Short Report",
                                    font: 20,
                                    color: provider.selectedTab == 1
                                        ? backgroundColorLight
                                        : shadowColorDark)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 4.0, bottom: 8.0),
                child: CupertinoSearchTextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    // SearchMutation(value);
                  },
                  decoration: BoxDecoration(
                    color: backgroundColorLight,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.lstTeacherChr.length,
                  itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            provider.selectedIndex = index;
                            context.push(routesTeacherChrDetails,
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
                                color: containerColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        text_medium(provider
                                            .lstTeacherChr[index].teacherName),
                                        provider.lstTeacherChr[index].image ==
                                                ''
                                            ? const CircleAvatar(
                                                radius: 33,
                                                backgroundImage: AssetImage(
                                                    "assets/avaters/Avatar Default.jpg"))
                                            : CircleAvatar(
                                                radius: 33,
                                                backgroundImage: NetworkImage(
                                                    "${getuserimage}Teacher/${provider.lstTeacherChr[index].image}")),
                                      ],
                                    ),
                                  ),
                                  cardText('Date: ',
                                      provider.lstTeacherChr[index].date),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: text_medium(
                                            provider
                                                .lstTeacherChr[index].status,
                                            color: provider.lstTeacherChr[index]
                                                        .status ==
                                                    'Held'
                                                ? primaryColor
                                                : provider.lstTeacherChr[index]
                                                            .status ==
                                                        'Not Held'
                                                    ? Colors.red
                                                    : Colors.redAccent),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 4,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                        color: provider.lstTeacherChr[index]
                                                    .status ==
                                                'Held'
                                            ? primaryColor
                                            : provider.lstTeacherChr[index]
                                                        .status ==
                                                    'Not Held'
                                                ? Colors.red
                                                : Colors.redAccent,
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(99.0))),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))),
            ],
          );
  }
}
