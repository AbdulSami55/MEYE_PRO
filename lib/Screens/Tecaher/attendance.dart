import 'package:flutter/material.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import '../../widget/components/std_teacher_appbar.dart';
import 'components/glass_container.dart';

class AttendanceCamera extends StatelessWidget {
  const AttendanceCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          stdteacherappbar(context),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(),
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  glassContainer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Abdul Sami'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Abdul Sami'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Abdul Sami'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Abdul Sami'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Abdul Sami'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Abdul Sami'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Abdul Sami'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Abdul Sami'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Abdul Sami'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                )
                              ],
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1.0),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0.2)
                                ],
                                stops: const [0.0, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(child: text_medium("Save")),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
