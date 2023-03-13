import 'package:codedesign/Components/Cards/course_section_card.dart';
import 'package:codedesign/Model/course.dart';
import 'package:codedesign/constants.dart';
import 'package:flutter/material.dart';

class CourseSectionList extends StatelessWidget {
  const CourseSectionList({Key? key}) : super(key: key);

  List<Widget> getCourseSections() {
    List<Widget> cards = [];
    for (var course in courseSections) {
      cards.add(CourseSectionCard(course: course));
    }
    cards.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        'No more course section to view \n for more in our courses',
        style: kCaptionLabelStyle,
        textAlign: TextAlign.center,
      ),
    ));
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: getCourseSections(),
      ),
    );
  }
}
