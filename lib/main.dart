import 'package:flutter/material.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/screens/sign_up/sign_up_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTokClone',
      theme: ThemeData(
        primaryColor: Color(0xFFE9435A),
      ),
      home: SignUpScreen()
    );
  }
}