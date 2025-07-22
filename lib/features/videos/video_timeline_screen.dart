import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  List<Color> colors = [
    Colors.blue,
    Colors.teal,
    Colors.yellow,
    Colors.pink,
  ];

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(
        milliseconds: 100,
      ),
      curve: Curves.linear,
    );

    if (page == _itemCount - 1) {
      _itemCount += 4;
      colors.addAll([
        // addAll 어떤 리스트에 [..]를 추가.
        Colors.blue,
        Colors.teal,
        Colors.yellow,
        Colors.pink,
      ]);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // builder 메소드: children 동시에 render x. 필요할 때 렌더
      controller: _pageController,
      itemBuilder: (context, index) => Container(
        color: colors[index], // index
        child: Center(
          child: Text("Screen $index"),
        ),
      ),
      itemCount: _itemCount, // 개수 알려줘야함.
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged, // int 변수는 flutter가 알아서 현재 페이지로 계산.
    );
  }
}
