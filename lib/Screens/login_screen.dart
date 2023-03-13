import 'package:codedesign/Screens/home_screen.dart';
import 'package:codedesign/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool visible = false;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
  }

  Future<void> creatNewUserData() async {
    _firestore.collection('users').doc(_auth.currentUser?.uid).set({
      'name': 'user',
      'uid': _auth.currentUser?.uid,
      'bio': 'design+code student',
      'completed': [],
      'recents': [],
      'badges': [],
      'certificates': [],
      'profilePic': '',
      'continue': []
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    transform: Matrix4.translationValues(0, -60, 0),
                    child:
                        Image.asset('asset/illustrations/illustration-14.png'),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, -170, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Learn to design\nand code apps',
                          textAlign: TextAlign.center,
                          style: kLargeTitleStyle.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        Text(
                          'Completed courses about the best\ntools and designed systems',
                          textAlign: TextAlign.center,
                          style: kHeadlineLabelStyle.copyWith(
                              color: Colors.white70),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                transform: Matrix4.translationValues(0, -130, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 53),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log in to',
                        style: kTitle1Style,
                      ),
                      Text(
                        'Start learning',
                        style:
                            kTitle1Style.apply(color: const Color(0xFF5B4CF0)),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: kShadowColor,
                              offset: Offset(0, 12),
                              blurRadius: 16.0,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 6.0,
                                left: 18.0,
                                right: 18.0,
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                cursorColor: kPrimaryLabelColor,
                                decoration: InputDecoration(
                                  icon: const Icon(
                                    Icons.email,
                                    color: Color(0xFF5488F1),
                                    size: 20,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Email Address',
                                  hintStyle: kLoginTextStyle,
                                ),
                                style: kLoginTextStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 6.0,
                                left: 18.0,
                                right: 4.0,
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: !visible,
                                cursorColor: kPrimaryLabelColor,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        visible = !visible;
                                      });
                                    },
                                    child: Icon(
                                      visible
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_outlined,
                                      color: const Color(0xFF5488F1),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.lock,
                                    color: Color(0xFF5488F1),
                                    size: 20,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: kLoginTextStyle,
                                ),
                                style: kLoginTextStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          } on FirebaseAuthException catch (err) {
                            if (err.code == 'user-not-found') {
                              try {
                                await _auth
                                    .createUserWithEmailAndPassword(
                                        email: email, password: password)
                                    .then((user) {
                                  user.user?.sendEmailVerification();
                                  creatNewUserData();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                });
                                // ignore: empty_catches
                              } catch (e) {}
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('error'),
                                      content: Text(err.message.toString()),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK!'),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          }
                        },
                        child: Container(
                          height: 47.0,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF73A0F4),
                                Color(0xFF4A47F5),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Log in',
                              style: kCalloutLabelStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          _auth
                              .sendPasswordResetEmail(email: email)
                              .then((value) => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Email sent'),
                                      content: const Text(
                                          'the password reset email has been sent'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK!'),
                                        ),
                                      ],
                                    );
                                  }));
                        },
                        child: Text(
                          'Forget password?',
                          style: kCalloutLabelStyle.copyWith(
                              color: const Color(0x721B1E9C)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
