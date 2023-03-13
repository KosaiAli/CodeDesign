import 'package:flutter/material.dart';

import '../constants.dart';

class SideBarButton extends StatelessWidget {
  const SideBarButton({Key? key, required this.triggerAnimation})
      : super(key: key);

  final Function triggerAnimation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        triggerAnimation();
      },
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
                color: kShadowColor, offset: Offset(0, 14), blurRadius: 24.0)
          ],
        ),
        child: Image.asset(
          'asset/icons/icon-sidebar.png',
        ),
      ),
    );
  }
}
