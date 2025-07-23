import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({super.key, required this.onVideoFinished});

  final Function onVideoFinished;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/air.mp4");

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize(); // 컨트롤러 이니셜라이즈.
    _videoPlayerController.play();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      // 초기화 확인
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        // 비디오 길이 == 현재 영상 위치
        widget.onVideoFinished();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child:
              _videoPlayerController
                  .value
                  .isInitialized // 초기화 돼있으면
              ? VideoPlayer(_videoPlayerController) // 컨트롤러 자체를 vp에 넘기고
              : Container(
                  // 아니면 검정 배경
                  color: Colors.black,
                ),
        ),
      ],
    );
  }
}
