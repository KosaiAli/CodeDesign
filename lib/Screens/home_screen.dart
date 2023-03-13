import 'package:codedesign/Components/Lists/explore_course_list.dart';
import 'package:codedesign/Components/home_screen_nav_bar.dart';
import 'package:codedesign/Components/Lists/recent_courses_list.dart';
import 'package:codedesign/Screens/continue_watching_screen.dart';
import 'package:codedesign/Screens/sidebar_screen.dart';
import 'package:codedesign/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<Offset> slideanimation;
  late Animation<double> fadeAnimation;
  late AnimationController slideanimationcontroller;
  bool sidebarHidden = true;
  @override
  void initState() {
    super.initState();

    slideanimationcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    slideanimation = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(
            parent: slideanimationcontroller, curve: Curves.easeInBack));
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: slideanimationcontroller, curve: Curves.easeInBack));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: sidebarHidden ? 1.02 : 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: HomeScreenNavBar(triggerAnimation: () {
                        setState(() {
                          sidebarHidden = false;
                        });
                        slideanimationcontroller.forward();
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Recents',
                            style: kLargeTitleStyle,
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            '23 Courses, more coming',
                            style: kSubtitleStyle,
                          ),
                        ],
                      ),
                    ),
                    const RecentCoursesList(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Explore',
                            style: kTitle1Style,
                          ),
                        ],
                      ),
                    ),
                    const ExploreCourseList()
                  ],
                ),
              ),
            ),
          ),
          const ContinueWatchingScreen(),
          IgnorePointer(
            ignoring: sidebarHidden,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    slideanimationcontroller.reverse();
                    setState(() {
                      sidebarHidden = true;
                    });
                  },
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Container(
                      color: const Color.fromRGBO(36, 38, 41, 0.4),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                SlideTransition(
                  position: slideanimation,
                  child: const SafeArea(
                    child: SideBarScreen(),
                    bottom: false,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
