import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedesign/Components/Cards/explore_course_card.dart';
import 'package:codedesign/Model/course.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExploreCourseList extends StatefulWidget {
  const ExploreCourseList({Key? key}) : super(key: key);

  @override
  State<ExploreCourseList> createState() => _ExploreCourseListState();
}

class _ExploreCourseListState extends State<ExploreCourseList> {
  List<Course> exploreCoursesList = [];
  final _firestore = FirebaseFirestore.instance;
  bool loaded = false;

  @override
  void initState() {
    grapCourses();

    super.initState();
  }

  void grapCourses() async {
    if (!loaded) {
      await _firestore.collection('courses').get().then((snapshot) {
        for (var doc in snapshot.docs) {
          exploreCoursesList.add(Course(
              courseTitle: doc['courseTitle'],
              courseSubtitle: doc['courseSubtitle'],
              background: LinearGradient(colors: [
                Color(int.parse(doc['colors'][0])),
                Color(int.parse(doc['colors'][1]))
              ]),
              illustration: doc['illustration'],
              logo: doc['logo']));
        }
      });
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: loaded
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 20.0 : 0.0),
                    child: ExploreCourseCard(
                      course: exploreCoursesList[index],
                    ),
                  );
                },
                itemCount: exploreCoursesList.length,
                scrollDirection: Axis.horizontal,
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? 20.0 : 0.0, right: 20),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 280,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(41.0)),
                      ),
                    ),
                  );
                },
                itemCount: 2,
                scrollDirection: Axis.horizontal,
              ),
      ),
    );
  }
}
