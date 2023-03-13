import 'package:codedesign/Model/course.dart';
import 'package:codedesign/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ExploreCourseCard extends StatefulWidget {
  const ExploreCourseCard({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  State<ExploreCourseCard> createState() => _ExploreCourseCardState();
}

class _ExploreCourseCardState extends State<ExploreCourseCard> {
  final _storage = FirebaseStorage.instance;
  String illustrationURL = '';
  @override
  void initState() {
    super.initState();
    getillustration();
  }

  void getillustration() async {
    _storage
        .ref('illustrations/${widget.course.illustration}')
        .getDownloadURL()
        .then((value) {
      setState(() {
        illustrationURL = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(41.0),
        child: Container(
          width: 280,
          height: 120,
          decoration: BoxDecoration(
            gradient: widget.course.background,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.course.courseSubtitle,
                        style: kCardSubtitleStyle,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        widget.course.courseTitle,
                        style: kCardTitleStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (illustrationURL != '')
                      Image.network(
                        illustrationURL,
                        fit: BoxFit.cover,
                        height: 100,
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
