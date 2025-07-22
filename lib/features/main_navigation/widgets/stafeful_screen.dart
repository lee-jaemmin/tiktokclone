import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclone/constants/sizes.dart';

class StafefulScreen extends StatefulWidget {
  const StafefulScreen({super.key});

  @override
  State<StafefulScreen> createState() => _StafefulScreenState();
}

class _StafefulScreenState extends State<StafefulScreen> {
  int click = 0;

  void _increase() {
    click += 1;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$click',
            style: TextStyle(
              fontSize: Sizes.size44,
            ),
          ),
          TextButton(
            style: ButtonStyle(
              iconSize: WidgetStatePropertyAll(Sizes.size24),
            ),
            onPressed: _increase,
            child: Text(
              '+',
            ),
          ),
        ],
      ),
    );
  }
}
