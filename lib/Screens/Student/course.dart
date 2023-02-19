import 'package:flutter/material.dart' show Color;

class Course {
  final String title, description, iconSrc;
  final Color color;

  Course({
    required this.title,
    this.description = 'Mobile Application Development',
    this.iconSrc = "assets/avaters/Avatar 2.jpg",
    this.color = const Color(0xFF7553F6),
  });
}

final List<Course> courses = [
  Course(
    title: "Mobile Application Development",
  ),
  Course(
    title: "Visual Programing",
    iconSrc: "assets/avaters/Avatar 3.jpg",
    color: const Color(0xFF80A4FF),
  ),
];

final List<Course> recentCourses = [
  Course(title: "Visual Programing"),
  Course(
    title: "Calculus",
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/avaters/Avatar 3.jpg",
  ),
  Course(title: "Human Resource Management"),
  Course(
    title: "Mobile Application Development",
    color: const Color(0xFF9CC5FF),
    iconSrc: "assets/avaters/Avatar 2.jpg",
  ),
];
