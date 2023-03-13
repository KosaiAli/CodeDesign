import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedesign/Components/Cards/cours_card.dart';
import 'package:codedesign/Model/course.dart';
import 'package:codedesign/Screens/course_screen.dart';
import 'package:codedesign/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecentCoursesList extends StatefulWidget {
  const RecentCoursesList({Key? key}) : super(key: key);

  @override
  State<RecentCoursesList> createState() => _RecentCoursesListState();
}

class _RecentCoursesListState extends State<RecentCoursesList> {
  List<Container> indicators = [];
  bool loaded = false;
  int currentPage = 0;
  final List<Course> _recentcourses = [];
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void getRecentsCourses() async {
    List<dynamic> recents = [];
    await _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((snapshot) {
      recents = snapshot.data()!['recents'];
    });
    _firestore.collection('courses').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        for (var element in recents) {
          if (doc['courseTitle'] == element) {
            _recentcourses.add(Course(
                courseTitle: doc['courseTitle'],
                courseSubtitle: doc['courseSubtitle'],
                background: LinearGradient(colors: [
                  Color(int.parse(doc['colors'][0])),
                  Color(int.parse(doc['colors'][1]))
                ]),
                illustration: doc['illustration'],
                logo: doc['logo']));
          }
        }
      }
    }).then((value) => setState(() {
          loaded = true;
        }));
  }

  Widget updateIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _recentcourses.map((course) {
        var index = _recentcourses.indexOf(course);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: index == currentPage ? 25.0 : 7.0,
          height: 7.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: index == currentPage ? Colors.blue : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    getRecentsCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            width: double.infinity,
            height: 375,
            child: loaded
                ? _recentcourses.isNotEmpty
                    ? PageView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => CourseScreen(
                                        course: _recentcourses[index]),
                                    fullscreenDialog: true),
                              );
                            },
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: currentPage == index ? 1 : 0.5,
                              child: AnimatedPadding(
                                duration: const Duration(milliseconds: 300),
                                padding: index == currentPage
                                    ? const EdgeInsets.only(top: 15)
                                    : const EdgeInsets.only(top: 55),
                                child: ReccentCourseCard(
                                  course: _recentcourses[index],
                                ),
                              ),
                            ),
                          );
                        },
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemCount: _recentcourses.length,
                        controller: PageController(
                          viewportFraction: 0.67,
                          initialPage: 0,
                        ),
                      )
                    : Center(
                        child: Text(
                        'No recent courses',
                        style: kTitle2Style,
                      ))
                : PageView.builder(
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          child: Container(
                            width: 240,
                            height: 240,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(41.0)),
                          ),
                        ),
                      );
                    },
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemCount: 2,
                    controller: PageController(
                      viewportFraction: 0.67,
                      initialPage: 0,
                    ),
                  ),
          ),
        ),
        if (loaded)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: updateIndicators(),
          )
      ],
    );
  }
}
