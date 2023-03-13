import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedesign/Components/side_barrow.dart';
import 'package:codedesign/Model/side_bar.dart';
import 'package:codedesign/Screens/login_screen.dart';
import 'package:codedesign/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SideBarScreen extends StatefulWidget {
  const SideBarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SideBarScreen> createState() => _SideBarScreenState();
}

class _SideBarScreenState extends State<SideBarScreen> {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseFirestore.instance;
  var photoURL = FirebaseAuth.instance.currentUser?.photoURL;
  String user = '';
  @override
  void initState() {
    _storage
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        user = value.data()!['name'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: const BoxDecoration(
        color: kSidebarBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(34.0),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: photoURL == null
                          ? Image.asset('asset/images/user.png')
                          : Image.network(
                              photoURL.toString(),
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                            )),
                  radius: 21.0,
                ),
                const SizedBox(
                  width: 17,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user,
                      style: kHeadlineLabelStyle,
                    ),
                    Text(
                      'License ends on 21 Jan,2022',
                      style: kSearchPlaceholderStyle,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            SideBarRow(
              sideBar: sideBarItem[0],
            ),
            const SizedBox(
              height: 32.0,
            ),
            SideBarRow(
              sideBar: sideBarItem[1],
            ),
            const SizedBox(
              height: 32.0,
            ),
            SideBarRow(
              sideBar: sideBarItem[2],
            ),
            const SizedBox(
              height: 32.0,
            ),
            SideBarRow(
              sideBar: sideBarItem[3],
            ),
            const SizedBox(
              height: 32.0,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                _auth.signOut().then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                });
              },
              child: Row(
                children: [
                  const Image(
                    image: AssetImage('asset/icons/icon-logout.png'),
                    width: 17.0,
                  ),
                  const SizedBox(
                    width: 17.0,
                  ),
                  Text(
                    'Log Out',
                    style: kSecondaryCalloutLabelStyle,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
