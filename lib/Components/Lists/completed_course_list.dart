import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedesign/Components/Cards/completed_course_card.dart';
import 'package:codedesign/Model/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CompletedCourseList extends StatefulWidget {
  const CompletedCourseList({Key? key}) : super(key: key);

  @override
  State<CompletedCourseList> createState() => _CompletedCourseListState();
}

class _CompletedCourseListState extends State<CompletedCourseList> {
  final List<Course> _completedCourses = [];
  bool loaded = false;
  int currentPage = 0;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    getCompletedCourses();
    super.initState();
  }

  void getCompletedCourses() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((snapshot) async {
      for (var course in snapshot.data()!['completed']) {
        await _firestore.collection('courses').doc(course).get().then((value) {
          _completedCourses.add(Course(
              courseTitle: value['courseTitle'],
              courseSubtitle: value['courseSubtitle'],
              background: LinearGradient(colors: [
                Color(int.parse(value['colors'][0])),
                Color(int.parse(value['colors'][1]))
              ]),
              illustration: value['illustration'],
              logo: value['logo']));
          // print(_completedCourses[0].courseTitle);
        });
      }
    }).then((value) {
      setState(() {
        loaded = true;
      });
    });
  }

  Widget updateIdicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _completedCourses.map((course) {
        int index = _completedCourses.indexOf(course);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: index == currentPage ? 14.0 : 7.0,
          height: 7.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: index == currentPage ? Colors.blue : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: loaded
              ? PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CompletedCourseCard(
                      course: _completedCourses[index],
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: _completedCourses.length,
                  controller:
                      PageController(initialPage: 0, viewportFraction: 0.75),
                )
              : PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Container(
                          width: 260.0,
                          height: 140.0,
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
                  controller:
                      PageController(initialPage: 0, viewportFraction: 0.75),
                ),
        ),
        updateIdicators()
      ],
    );
  }
}
