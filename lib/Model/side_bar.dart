import 'package:flutter/material.dart';

class SideBar {
  SideBar({required this.title, required this.background, required this.icon});
  String title;
  LinearGradient background;
  Icon icon;
}

var sideBarItem = [
  SideBar(
    title: 'Home',
    background: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF00AEFF),
        Color(0xFF0076FF),
      ],
    ),
    icon: const Icon(
      Icons.home,
      color: Colors.white,
    ),
  ),
  SideBar(
    title: 'Courses',
    background: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFA7D75),
        Color(0xFFC23D61),
      ],
    ),
    icon: const Icon(
      Icons.library_books,
      color: Colors.white,
    ),
  ),
  SideBar(
    title: 'Billing',
    background: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFAD64A),
        Color(0xFFEA880F),
      ],
    ),
    icon: const Icon(
      Icons.credit_card,
      color: Colors.white,
    ),
  ),
  SideBar(
    title: 'Settings',
    background: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF4E62CC),
        Color(0xFF282A78),
      ],
    ),
    icon: const Icon(
      Icons.settings,
      color: Colors.white,
    ),
  ),
];
