import 'package:flutter/material.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';

class VideoCaption extends StatefulWidget {
  const VideoCaption({super.key, required this.text});
  final String text;

  @override
  State<VideoCaption> createState() => _VideoCaptionState();
}

class _VideoCaptionState extends State<VideoCaption> {
  bool _showLongCaption = false;
  // 초기화.

  void _onCaptionTap() {
    _showLongCaption = !_showLongCaption;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Jaemin",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v10,
        GestureDetector(
          onTap: _onCaptionTap,
          child: Text(
            widget.text,
            overflow: _showLongCaption ? null : TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
