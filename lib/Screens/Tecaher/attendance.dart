import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import '../../widget/components/std_teacher_appbar.dart';
import 'components/glass_container.dart';

class AttendanceCamera extends StatelessWidget {
  const AttendanceCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
                            text_medium('Ali Husnain'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Umair Ali'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Zeeshan Khan'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Aliya Malik'),
                            text_medium('P')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Muazamil Hafeez'),
                            text_medium('A')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text_medium('Aftab Khan'),
                            text_medium('A')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
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
                              border:
                                  Border.all(color: Colors.white, width: 1.0),
                              gradient: const LinearGradient(
                                colors: [Colors.white, Colors.white],
                                stops: [0.0, 1.0],
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
