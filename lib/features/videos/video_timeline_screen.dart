import 'package:flutter/material.dart';
import 'package:tiktokclone/features/videos/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;
  final Duration _scrollDuration = Duration(
    milliseconds: 100,
  );

  final Curve _scrollCurve = Curves.linear;

  final PageController _pageController = PageController();

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _itemCount - 1) {
      _itemCount += 4;

      setState(() {});
    }
  }

  void _onVideoFinished() {
    return; // 다음 영상 x 현재 영상 반복 o
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // builder 메소드: children 동시에 render x. 필요할 때 렌더
      controller: _pageController,
      itemBuilder: (context, index) => VideoPost(
        onVideoFinished: _onVideoFinished,
        index: index,
      ),
      itemCount: _itemCount, // 개수 알려줘야함.
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged, // int 변수는 flutter가 알아서 현재 페이지로 계산.
    );
  }
}
