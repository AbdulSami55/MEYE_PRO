import 'package:flutter/material.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';

import '../../../utilities/constants.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.title,
    required this.instructor,
    this.color = containerCardColor,
    this.iconSrc = "assets/avaters/Avatar Default.jpg",
    required this.percentage,
  }) : super(key: key);

  final String title, iconSrc, instructor;
  final Color color;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width * 0.96,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: containerColor, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  text_medium("Instructor: $instructor",
                      color: Colors.white38, font: 15),
                  const Spacer(),
                  text_medium("Attendance: $percentage%", color: Colors.white)
                ],
              ),
            ),
          ),
          iconSrc == ""
              ? const CircleAvatar(
                  radius: 33,
                  backgroundImage:
                      AssetImage("assets/avaters/Avatar Default.jpg"),
                )
              : CircleAvatar(
                  radius: 33,
                  backgroundImage:
                      NetworkImage("$getuserimage" "Teacher/$iconSrc")),
        ],
      ),
    );
  }
}
