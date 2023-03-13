import 'dart:io';
import 'dart:math';

import 'package:codedesign/Components/certificates_viewer.dart';
import 'package:codedesign/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: kCardPopupBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                        color: kShadowColor,
                        offset: Offset(0, 16),
                        blurRadius: 32)
                  ],
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(35))),
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            constraints: const BoxConstraints(
                                minWidth: 40, maxWidth: 40.0, maxHeight: 34.0),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: kSecondaryLabelColor,
                            ),
                          ),
                          Text(
                            'Profile',
                            style: kCalloutLabelStyle,
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                      color: kShadowColor,
                                      offset: Offset(0, 12),
                                      blurRadius: 24)
                                ]),
                            child: Icon(Platform.isAndroid
                                ? Icons.settings
                                : CupertinoIcons.settings),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 34.0, vertical: 32.0),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: CustomPaint(
                                  painter: AvatarCirclePainter(),
                                  child: const Padding(
                                    padding: EdgeInsets.all(9.0),
                                    child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'asset/images/profile.jpg')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Kosai Ali',
                                style: kTitle2Style,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Flutter Developer',
                                style: kSecondaryCalloutLabelStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Badges',
                            style: kHeadlineLabelStyle,
                          ),
                          Row(
                            children: [
                              Text(
                                'See all',
                                style: kCaptionLabelStyle,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: kSecondaryLabelColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 105,
                        child: ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 12, bottom: 12),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: kShadowColor,
                                            offset: Offset(0, 5),
                                            blurRadius: 8,
                                            spreadRadius: 0.1)
                                      ]),
                                  child: Image.asset(
                                    'asset/badges/badge-0${index + 1}.png',
                                  ),
                                ),
                              );
                            })),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, right: 12, top: 32, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Certificates',
                    style: kHeadlineLabelStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        'See all',
                        style: kCaptionLabelStyle,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: kSecondaryLabelColor,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Certificates(certificatesPath: []),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 12, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Completed courses',
                    style: kHeadlineLabelStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        'See all',
                        style: kCaptionLabelStyle,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: kSecondaryLabelColor,
                      )
                    ],
                  ),
                ],
              ),
            ),
            // CompletedCourseCard(course: completedCourses[1]),
          ],
        ),
      )),
    );
  }
}

class AvatarCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    var radius = max(size.width / 2, size.height / 2);
    var prush = Paint()
      ..shader = const LinearGradient(
              colors: [Color(0xFF00AEFF), Color(0xFF0076FF)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var circleprush = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, circleprush);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        pi * 9 / 6, false, prush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
