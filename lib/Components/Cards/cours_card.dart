import 'package:codedesign/Model/course.dart';
import 'package:codedesign/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ReccentCourseCard extends StatefulWidget {
  const ReccentCourseCard({required this.course, Key? key}) : super(key: key);
  final Course course;

  @override
  State<ReccentCourseCard> createState() => _ReccentCourseCardState();
}

class _ReccentCourseCardState extends State<ReccentCourseCard> {
  final _storage = FirebaseStorage.instance;
  String? illustraion;
  String? logo;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await _storage
        .ref('illustrations/${widget.course.illustration}')
        .getDownloadURL()
        .then((value) {
      setState(() {
        illustraion = value;
      });
    });
    await _storage
        .ref('logos/${widget.course.logo}')
        .getDownloadURL()
        .then((value) {
      setState(() {
        logo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
                gradient: widget.course.background,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: widget.course.background.colors[0].withOpacity(0.3),
                    offset: const Offset(0, 20),
                    blurRadius: 32,
                  ),
                  BoxShadow(
                    color: widget.course.background.colors[1].withOpacity(0.3),
                    offset: const Offset(0, 20),
                    blurRadius: 32,
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 32.0, left: 26.0, right: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: widget.course.courseSubtitle,
                      child: Text(
                        widget.course.courseSubtitle,
                        style: kCardSubtitleStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Hero(
                      tag: widget.course.courseTitle,
                      child: Text(
                        widget.course.courseTitle,
                        style: kCardTitleStyle,
                      ),
                    ),
                    if (illustraion != null)
                      Expanded(
                        child: Hero(
                            tag: widget.course.illustration,
                            child: Image.network(
                              illustraion.toString(),
                              fit: BoxFit.cover,
                            )),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 42.0),
          child: Hero(
            tag: widget.course.logo.toString(),
            child: Container(
              child: logo != null
                  ? Image.network(logo.toString())
                  : const Text(''),
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: kShadowColor,
                      offset: Offset(0, 4),
                      blurRadius: 16.0)
                ],
              ),
              padding: const EdgeInsets.all(12.0),
            ),
          ),
        ),
      ],
    );
  }
}
