import 'package:flutter/material.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';

import '../../../utilities/constants.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.title,
    this.color = containerCardColor,
    this.iconSrc = "assets/avaters/Avatar 2.jpg",
  }) : super(key: key);

  final String title, iconSrc;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      height: 280,
      width: 260,
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
                  text_medium("Teach By: Mr Umer",
                      color: Colors.white38, font: 15),
                  const Spacer(),
                  text_medium("Attendance: 97%", color: Colors.white)
                ],
              ),
            ),
          ),
          CircleAvatar(radius: 30, backgroundImage: AssetImage(iconSrc)),
        ],
      ),
    );
  }
}
