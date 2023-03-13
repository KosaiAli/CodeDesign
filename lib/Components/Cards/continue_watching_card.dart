import 'package:codedesign/Model/course.dart';
import 'package:codedesign/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ConitinueWatchingCard extends StatefulWidget {
  const ConitinueWatchingCard({required this.course, Key? key})
      : super(key: key);
  final Course course;

  @override
  State<ConitinueWatchingCard> createState() => _ConitinueWatchingCardState();
}

class _ConitinueWatchingCardState extends State<ConitinueWatchingCard> {
  final _storage = FirebaseStorage.instance;
  String? illustration;
  @override
  void initState() {
    _storage
        .ref('illustrations/${widget.course.illustration}')
        .getDownloadURL()
        .then((value) {
      setState(() {
        illustration = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, right: 18.0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: widget.course.background,
                  borderRadius: BorderRadius.circular(41.0),
                  boxShadow: [
                    BoxShadow(
                      color:
                          widget.course.background.colors[0].withOpacity(0.3),
                      offset: const Offset(0, 20),
                      blurRadius: 20,
                    ),
                    BoxShadow(
                      color:
                          widget.course.background.colors[1].withOpacity(0.3),
                      offset: const Offset(0, 20),
                      blurRadius: 20,
                    ),
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(41.0),
                child: SizedBox(
                  width: 260.0,
                  height: 140.0,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (illustration != null)
                                Image.network(
                                  illustration.toString(),
                                  fit: BoxFit.cover,
                                  height: 110,
                                ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.course.courseSubtitle,
                              style: kCardSubtitleStyle,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              widget.course.courseTitle,
                              style: kCardTitleStyle,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Image.asset('asset/icons/icon-play.png'),
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: kShadowColor, offset: Offset(0, 4), blurRadius: 16.0)
              ],
            ),
            padding: const EdgeInsets.only(
                top: 12.5, bottom: 13.5, left: 20.5, right: 14.5),
          ),
        ],
      ),
    );
  }
}
