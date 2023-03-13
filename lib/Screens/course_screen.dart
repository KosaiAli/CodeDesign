import 'package:codedesign/Model/course.dart';
import 'package:codedesign/Screens/course_section_screen.dart';
import 'package:codedesign/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key, required this.course}) : super(key: key);
  final Course course;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with TickerProviderStateMixin {
  late PanelController panelController;
  late Animation<Offset> slideanimation;
  late Animation<double> fadeAnimation;
  late AnimationController slideanimationcontroller;
  bool slideAnimated = false;
  @override
  void initState() {
    panelController = PanelController();
    slideanimationcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    slideanimation = Tween(begin: const Offset(0, 2), end: const Offset(0, 0))
        .animate(CurvedAnimation(
            parent: slideanimationcontroller, curve: Curves.easeInBack));

    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: slideanimationcontroller, curve: Curves.easeInBack));

    super.initState();
  }

  Widget indicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < 9; i++) {
      indicators.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          width: i == 0 ? 26 : 8,
          height: 8,
          decoration: BoxDecoration(
              color: i == 0 ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(05)),
        ),
      ));
    }
    return Row(
      children: indicators,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SlidingUpPanel(
          panel: const CourseSectionScreen(),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(34.0)),
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.height * 0.95,
          color: kBackgroundColor,
          controller: panelController,
          body: ListView(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        gradient: widget.course.background,
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, left: 25.0, right: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: widget.course.logo.toString(),
                                    child: Container(
                                      child: Image.asset(
                                          'asset/logos/${widget.course.logo}'),
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
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Hero(
                                          tag: widget.course.courseSubtitle,
                                          child: Text(
                                            widget.course.courseSubtitle,
                                            style: kSecondaryCalloutLabelStyle
                                                .copyWith(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Hero(
                                          tag: widget.course.courseTitle,
                                          child: Text(
                                            widget.course.courseTitle,
                                            style: kLargeTitleStyle.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.black.withOpacity(0.6)),
                                      child: const Icon(
                                        Icons.close_sharp,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 28.0,
                            ),
                            Expanded(
                              child: Hero(
                                tag: widget.course.illustration,
                                child: Image(
                                    image: AssetImage(
                                        'asset/illustrations/${widget.course.illustration}'),
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.cover),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: Container(
                      width: 70,
                      height: 70,
                      padding: const EdgeInsets.only(
                          top: 12.5, bottom: 13.5, left: 20.5, right: 14.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: kShadowColor,
                              offset: Offset(0, 12),
                              blurRadius: 32)
                        ],
                      ),
                      child: Image.asset('asset/icons/icon-play.png'),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, left: 28.0, right: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: widget.course.background,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: kBackgroundColor,
                                  shape: BoxShape.circle),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: CircleAvatar(
                                  child: Icon(Icons.people_sharp,
                                      color: Colors.white),
                                  backgroundColor: kCourseElementIconColor,
                                  radius: 21.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '28.7K',
                              style: kTitle2Style,
                            ),
                            Text(
                              'Students',
                              style: kSearchPlaceholderStyle,
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: widget.course.background,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: kBackgroundColor,
                                  shape: BoxShape.circle),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: CircleAvatar(
                                  child: Icon(CupertinoIcons.news_solid,
                                      color: Colors.white),
                                  backgroundColor: kCourseElementIconColor,
                                  radius: 21.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '12.4K',
                              style: kTitle2Style,
                            ),
                            Text(
                              'Comments',
                              style: kSearchPlaceholderStyle,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 28, horizontal: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    indicators(),
                    GestureDetector(
                      onTap: () {
                        panelController.open();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             CourseSectionScreen()));
                        // slideanimationcontroller.forward();
                        // setState(() {
                        //   // sidebarHidden = true;
                        //   slideAnimated = true;
                        // });
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 12),
                                blurRadius: 24)
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'View All',
                            style: kSearchTextStyle,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5 years ago, I couldn’t write a single line of Swift. I learned it and moved to React, Flutter while using increasingly complex design tools. I don’t regret learning them because SwiftUI takes all of their best concepts. It is hands-down the best way for designers to take a first step into code.',
                      style: kBodyLabelStyle,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      'About this course',
                      style: kTitle1Style,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      'This course was written for people who are passionate about design and about Apple’s SwiftUI. It beginner-friendly, but it is also packed with tricks and cool workflows about building the best UI. Currently, Xcode 11 is still in beta so the installation process may be a little hard. However, once you get everything working, then it’ll get much friendlier!',
                      style: kBodyLabelStyle,
                    ),
                    const SizedBox(
                      height: 24.0,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
