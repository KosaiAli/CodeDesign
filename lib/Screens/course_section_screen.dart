import 'package:codedesign/Components/Lists/course_section_list.dart';
import 'package:codedesign/Model/course.dart';
import 'package:codedesign/constants.dart';
import 'package:flutter/material.dart';

class CourseSectionScreen extends StatefulWidget {
  const CourseSectionScreen({Key? key}) : super(key: key);

  @override
  State<CourseSectionScreen> createState() => _CourseSectionScreenState();
}

class _CourseSectionScreenState extends State<CourseSectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 120,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34.0),
                bottomLeft: Radius.circular(35.0)),
            boxShadow: [
              BoxShadow(
                color: kShadowColor,
                offset: Offset(0, 16),
                blurRadius: 32.0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Course Sections',
                style: kTitle1Style,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                '${courseSections.length + 1} sections',
                style: kSubtitleStyle,
              )
            ],
          ),
        ),
        const CourseSectionList(),
      ],
    );
  }
}
