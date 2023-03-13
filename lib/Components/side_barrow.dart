import 'package:codedesign/Model/side_bar.dart';
import 'package:flutter/material.dart';

class SideBarRow extends StatelessWidget {
  const SideBarRow({Key? key, required this.sideBar}) : super(key: key);
  final SideBar sideBar;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42.0,
          height: 42.0,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: sideBar.background,
          ),
          child: sideBar.icon,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(sideBar.title)
      ],
    );
  }
}
