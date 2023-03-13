import 'package:codedesign/Components/Lists/continue_watching_list.dart';
import 'package:codedesign/Components/certificates_viewer.dart';
import 'package:codedesign/constants.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ContinueWatchingScreen extends StatefulWidget {
  const ContinueWatchingScreen({Key? key}) : super(key: key);

  @override
  State<ContinueWatchingScreen> createState() => _ContinueWatchingScreenState();
}

class _ContinueWatchingScreenState extends State<ContinueWatchingScreen> {
  List<dynamic> certificates = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropEnabled: true,
      minHeight: 85,
      maxHeight: MediaQuery.of(context).size.height * 0.75,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(35)),
      backdropColor: kCardPopupBackgroundColor,
      boxShadow: const [
        BoxShadow(color: kShadowColor, offset: Offset(0, -12), blurRadius: 16),
      ],
      panel: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                width: 42.0,
                height: 4.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFC5CBD6),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Continue Watching',
              style: kTitle1Style,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: ContinueWatchingList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Certificates',
              style: kTitle2Style,
            ),
          ),
          const Expanded(
              child: Certificates(certificatesPath: [
            'certificate-01.png',
            'certificate-02.png',
            'certificate-03.png'
          ]))
        ],
      ),
    );
  }
}
