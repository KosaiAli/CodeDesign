import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedesign/Components/Lists/completed_course_list.dart';
import 'package:codedesign/Components/certificates_viewer.dart';
import 'package:codedesign/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Loading...';
  String bio = 'Loading...';
  bool loaded = false;
  List<dynamic> badges = [];
  List<dynamic> cer = [];
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  var photoURL = FirebaseAuth.instance.currentUser?.photoURL;
  @override
  void initState() {
    getUserData();
    loadbadges();
    super.initState();
  }

  void updateUserData() {
    _firestore.collection('users').doc(_auth.currentUser?.uid).update({
      'name': name,
      'bio': bio,
    }).then((value) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Success!'),
              content: const Text('User data has been updated!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK!'),
                )
              ],
            );
          });
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('UH-OH!'),
              content: Text(e),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Try Again'),
                )
              ],
            );
          });
    });
  }

  void getUserData() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((snapshot) {
      setState(() {
        name = snapshot.data()!['name'];
        bio = snapshot.data()!['bio'];
        cer = snapshot.data()!['certificates'];
      });
    });
  }

  Future loadbadges() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((snapshot) async {
      for (var badge in snapshot.data()!['badges']) {
        try {
          await _storage
              .ref('badges/$badge')
              .getDownloadURL()
              .then((value) => setState(() {
                    badges.add(value);
                  }));
          // ignore: empty_catches
        } catch (e) {}
      }
      setState(() {
        loaded = true;
      });
    });
  }

  void getProfilUrl() async {
    var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      File _image = File(pickedfile.path);
      _storage
          .ref('profile_pic/${_auth.currentUser?.uid}.jpg')
          .putFile(_image)
          .then((snapshot) {
        snapshot.ref.getDownloadURL().then((url) {
          _firestore
              .collection('users')
              .doc(_auth.currentUser?.uid)
              .update({'profilePic': url})
              .then((value) => _auth.currentUser?.updatePhotoURL(url))
              .then((value) {
                setState(() {
                  photoURL = FirebaseAuth.instance.currentUser?.photoURL;
                });
              });
        });
      });
    } else {}
  }

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
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Update your profile'),
                                      content: SizedBox(
                                        height: 120,
                                        child: Column(
                                          children: [
                                            TextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  name = value;
                                                });
                                              },
                                              controller: TextEditingController(
                                                  text: name),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  bio = value;
                                                });
                                              },
                                              controller: TextEditingController(
                                                  text: bio),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            updateUserData();
                                          },
                                          child: const Text('Update!'),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Container(
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
                                  ? Icons.edit
                                  : CupertinoIcons.pencil),
                            ),
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
                              GestureDetector(
                                onTap: () {
                                  getProfilUrl();
                                },
                                child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: CustomPaint(
                                    painter: AvatarCirclePainter(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(9.0),
                                      child: CircleAvatar(
                                          child: photoURL == null
                                              ? Image.asset(
                                                  'asset/images/user.png')
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  child: Image.network(
                                                      width: 71,
                                                      height: 71,
                                                      fit: BoxFit.cover,
                                                      photoURL.toString()),
                                                )),
                                    ),
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
                              loaded
                                  ? Text(
                                      name,
                                      style: kTitle2Style,
                                    )
                                  : Shimmer.fromColors(
                                      highlightColor: Colors.grey[100]!,
                                      baseColor: Colors.grey[300]!,
                                      child: Container(
                                          width: 80,
                                          height: 10,
                                          color: Colors.white),
                                    ),
                              const SizedBox(
                                height: 6,
                              ),
                              loaded
                                  ? Text(
                                      bio,
                                      style: kSecondaryCalloutLabelStyle,
                                    )
                                  : Shimmer.fromColors(
                                      highlightColor: Colors.grey[100]!,
                                      baseColor: Colors.grey[300]!,
                                      child: Container(
                                          width: 40,
                                          height: 10,
                                          color: Colors.white),
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
                    loaded
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: badges.isNotEmpty
                                ? SizedBox(
                                    width: double.infinity,
                                    height: 105,
                                    child: ListView.builder(
                                        itemCount: badges.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: ((context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12,
                                                right: 12,
                                                top: 12,
                                                bottom: 12),
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
                                                child: Image.network(
                                                    badges[index])),
                                          );
                                        })))
                                : const Text('No badges yet'),
                          )
                        : SizedBox(
                            width: double.infinity,
                            height: 105,
                            child: ListView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        top: 12,
                                        bottom: 12),
                                    child: Shimmer.fromColors(
                                      highlightColor: Colors.grey[100]!,
                                      baseColor: Colors.grey[300]!,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        width: 80,
                                        height: 10,
                                      ),
                                    ),
                                  );
                                })),
                          ),
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
            loaded
                ? Certificates(certificatesPath: cer)
                : Shimmer.fromColors(
                    highlightColor: Colors.grey[100]!,
                    baseColor: Colors.grey[300]!,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 28),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        height: 150,
                      ),
                    ),
                  ),
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
            const CompletedCourseList(),
            const SizedBox(
              height: 32,
            )
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
