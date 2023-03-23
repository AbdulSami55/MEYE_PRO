import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../widget/textcomponents/medium_text.dart';

Padding glassContainer() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(children: [
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 7,
          sigmaY: 7,
        ),
      ),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
              )
            ],
            border: Border.all(color: Colors.white, width: 1.0),
            gradient: const LinearGradient(
              colors: [Colors.white, Colors.white],
              stops: [0.0, 1.0],
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text_medium(
                'Discipline: Bcs-8b',
              ),
              const SizedBox(
                height: 5,
              ),
              text_medium(
                'Course: MAP',
              ),
              const SizedBox(
                height: 5,
              ),
              text_medium(
                'Date: ${DateTime.now().toString().split(' ')[0]}',
              )
            ],
          ),
        ),
      ),
    ]),
  );
}
