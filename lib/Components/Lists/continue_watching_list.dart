import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedesign/Components/Cards/continue_watching_card.dart';
import 'package:codedesign/Model/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContinueWatchingList extends StatefulWidget {
  const ContinueWatchingList({Key? key}) : super(key: key);

  @override
  State<ContinueWatchingList> createState() => _ContinueWatchingListState();
}

class _ContinueWatchingListState extends State<ContinueWatchingList> {
  int currentPage = 0;
  final List<Course> _continueCourses = [];
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool loaded = false;

  void getContinueCourses() async {
    List<dynamic> recents = [];
    await _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((snapshot) {
      recents = snapshot.data()!['continue'];
    });
    _firestore.collection('courses').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        for (var element in recents) {
          if (doc['courseTitle'] == element) {
            _continueCourses.add(Course(
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

  Widget updateIdicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _continueCourses.map((course) {
        int index = _continueCourses.indexOf(course);
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
  void initState() {
    getContinueCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ConitinueWatchingCard(
                course: _continueCourses[index],
              );
            },
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: _continueCourses.length,
            controller: PageController(initialPage: 0, viewportFraction: 0.75),
          ),
        ),
        updateIdicators()
      ],
    );
  }
}
