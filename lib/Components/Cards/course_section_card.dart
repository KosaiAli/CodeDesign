import 'package:codedesign/Model/course.dart';
import 'package:codedesign/constants.dart';
import 'package:flutter/material.dart';

class CourseSectionCard extends StatelessWidget {
  const CourseSectionCard({Key? key, required this.course}) : super(key: key);

  final Course course;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            gradient: course.background,
            boxShadow: const [
              BoxShadow(
                color: kShadowColor,
                offset: Offset(0, 12),
                blurRadius: 24.0,
              )
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 32,
            ),
            child: Stack(alignment: Alignment.centerRight, children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          course.courseSubtitle,
                          style: kCardSubtitleStyle,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          course.courseTitle,
                          style: kCardTitleStyle,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'asset/illustrations/${course.illustration}',
                    fit: BoxFit.cover,
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
