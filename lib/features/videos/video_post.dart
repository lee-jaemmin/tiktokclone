import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  // 외부에서 받는 거는 반드시 stateful에다가  선언
  final Function onVideoFinished;
  final int index;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/gh.MP4");

  bool _isPaused = false;
  final Duration _animationDuration = Duration(milliseconds: 300);

  late final AnimationController _animationController;

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize(); // 컨트롤러 이니셜라이즈.

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

  void _onVisibilityChange(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      // 화면이 100% (1) 보임 && 비디오가 재생 중이 아니면
      // 재생
      _videoPlayerController.play();
    }
  }

  void _ontogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      // 재생 중이면
      // pause, 아이콘 줄이기
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5, // 시작값 설정. upperBound 시작 유도
      duration: _animationDuration,
    );

    _animationController.addListener(() {
      // 애니메이션이 바뀔 때마다 호출
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChange,
      child: Stack(
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
          Positioned.fill(
            child: GestureDetector(
              onTap: _ontogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Transform.scale(
                  scale: _animationController.value,
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: _isPaused ? 1 : 0,
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size48,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
