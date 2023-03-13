import 'package:flutter/material.dart';

import '../constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                  color: kShadowColor, offset: Offset(0, 14), blurRadius: 24.0)
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                border: InputBorder.none,
                hintText: 'Search for courses',
                hintStyle: kSearchPlaceholderStyle),
          ),
        ),
      ),
    );
  }
}
