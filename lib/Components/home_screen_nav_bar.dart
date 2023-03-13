import 'package:codedesign/Components/search_field.dart';
import 'package:codedesign/Components/side_bar_button.dart';
import 'package:codedesign/Screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreenNavBar extends StatefulWidget {
  const HomeScreenNavBar({Key? key, required this.triggerAnimation})
      : super(key: key);

  final Function triggerAnimation;

  @override
  State<HomeScreenNavBar> createState() => _HomeScreenNavBarState();
}

class _HomeScreenNavBarState extends State<HomeScreenNavBar> {
  var photoURL = FirebaseAuth.instance.currentUser?.photoURL;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SideBarButton(triggerAnimation: widget.triggerAnimation),
        const SearchField(),
        const SizedBox(
          width: 24.0,
        ),
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.notifications),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
          child: CircleAvatar(
              child: photoURL == null
                  ? Image.asset('asset/images/user.png')
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.network(
                          width: 71,
                          height: 71,
                          fit: BoxFit.cover,
                          photoURL.toString()),
                    )),
        )
      ],
    );
  }
}
