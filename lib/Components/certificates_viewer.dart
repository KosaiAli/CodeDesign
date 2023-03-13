import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Certificates extends StatefulWidget {
  const Certificates({Key? key, required this.certificatesPath})
      : super(key: key);
  final List<dynamic> certificatesPath;

  @override
  State<Certificates> createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  final _storage = FirebaseStorage.instance;
  List<dynamic> cer = [];
  bool loaded = false;
  @override
  void initState() {
    loadCertificates();
    super.initState();
  }

  void loadCertificates() async {
    for (var c in widget.certificatesPath) {
      await _storage.ref('certificates/$c').getDownloadURL().then((value) {
        cer.add(value);
      });
    }
    setState(() {
      loaded = true;
    });
  }

  Widget certificatesView() {
    List<Widget> imageChildren = [];
    // print(widget.certificatesPath);
    cer.reversed.toList().asMap().forEach((index, certificate) {
      int degree;
      if (index == cer.length - 1) {
        degree = 0;
      } else {
        degree = Random().nextInt(10) - 5;
      }
      imageChildren.add(
        Transform.rotate(
          angle: degree * (pi / 180),
          child: Image.network(
            certificate,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
      );
    });
    if (cer.isNotEmpty) {
      return Stack(
        children: imageChildren,
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Center(child: Text('No certificates yet')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: certificatesView(),
      );
    }
    return Shimmer.fromColors(
      highlightColor: Colors.grey[100]!,
      baseColor: Colors.grey[300]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          height: 150,
        ),
      ),
    );
  }
}
