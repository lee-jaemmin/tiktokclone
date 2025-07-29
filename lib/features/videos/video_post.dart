import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/videos/widgets/video_button.dart';
import 'package:tiktokclone/features/videos/widgets/video_caption.dart';
import 'package:tiktokclone/features/videos/widgets/video_comments.dart';
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
  //with + Mixin == 클래스 (여기서는 STPS) 전체 복사
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/air.mp4");

  bool _isPaused = false;
  final Duration _animationDuration = Duration(milliseconds: 300);

  late final AnimationController _animationController;

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize(); // 컨트롤러 이니셜라이즈.
    await _videoPlayerController.setLooping(true);
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
      vsync: this, // 위젯 안 보일 때 애니메이션 동작 x
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5, // 시작값 설정. upperBound 시작 유도
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      // 영상 재생 중이면 pause.
      _ontogglePause();
    }
    await showModalBottomSheet(
      context: context,
      builder: (context) => VideoComments(),
    );
    // 유저가 댓글창 닫을 때까지 기다림. -> 뭔 말이야?
    _ontogglePause();
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
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    // 두 번째 인자는 무조건 AnimatedBuilder의 child
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
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
          Positioned(
            width: MediaQuery.of(context).size.width * 0.75,
            bottom: 20,
            left: 20,
            child: VideoCaption(
              text:
                  "Airshow in seoul it's a really long caption I love to talk really talkative. I just cannnot stop talking because talking is so fun!!!!!!!1",
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTnKq9TO4QuG5YCAPuQBNDwYKCdzbEmxmqjRFoNgwzWzra6Wr70jP6BYL7-FKcmqo_PVmjMRmWKymV265wmdh1OAA",
                  ),
                  radius: 25,
                  child: Text('woals'),
                ),
                Gaps.v20,
                VideoButton(icon: FontAwesomeIcons.solidHeart, text: "3.0M"),
                Gaps.v20,
                GestureDetector(
                  onTap: () => _onCommentTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "22.K",
                  ),
                ),
                Gaps.v20,
                VideoButton(icon: FontAwesomeIcons.share, text: "Share"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
