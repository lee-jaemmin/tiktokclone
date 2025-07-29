import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;
  bool _isLoved = false;
  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    // stateful이므로 context 전달 필요 x
    Navigator.of(context).pop();
  }

  void _onIsLoved() {
    _isLoved = !_isLoved;
    setState(() {});
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    // 다른 곳 누르면 키보드내려가게.
    _isWriting = false;
  }

  void _onStartWriting() {
    _isWriting = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // scaffdold를 감싸서 radius 적용!
      height: size.height * 0.8,
      // 댓글창 크기 조절
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size24,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          automaticallyImplyLeading: false, // 백 버튼 없애기
          title: Text('Comment'),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  separatorBuilder: (context, index) => Gaps.v20,
                  padding: EdgeInsets.only(
                    right: Sizes.size16,
                    left: Sizes.size16,
                    top: Sizes.size10,
                    bottom: Sizes.size96,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: Sizes.size18,
                        child: Text('재민'),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '재민',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size16,
                              ),
                            ),
                            Gaps.v2,
                            Text(
                              "Wow it's a aaaaaaaaaaaaaamaizng aaaaaaaaairplane show!!!!!!!",
                            ),
                            Gaps.h10,
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: _onIsLoved,
                            child: FaIcon(
                              FontAwesomeIcons.heart,
                              color: _isLoved
                                  ? Colors.red
                                  : Colors.grey.shade500,
                            ),
                          ),
                          Gaps.v4,
                          Text(
                            '9k',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                width: size.width,
                bottom: 0,
                child: BottomAppBar(
                  height: 70,
                  color: Colors.white,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade500,
                        foregroundColor: Colors.white,
                        radius: 18,
                        child: Text('재민'),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: TextField(
                          onTap: _onStartWriting,
                          // textInputAction true시 min,maxline 수동설정필요
                          minLines: null,
                          maxLines: null,
                          expands: true, // 새 줄 추가 가능
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            hintText: 'Write a comment',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.size12,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: EdgeInsets.all(
                              Sizes.size10,
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: Sizes.size12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.at,
                                    color: Colors.grey.shade700,
                                  ),
                                  Gaps.h10,
                                  FaIcon(
                                    FontAwesomeIcons.gift,
                                    color: Colors.grey.shade700,
                                  ),
                                  Gaps.h10,
                                  FaIcon(
                                    FontAwesomeIcons.faceSmile,
                                    color: Colors.grey.shade700,
                                  ),
                                  Gaps.h10,
                                  if (_isWriting)
                                    GestureDetector(
                                      onTap: _stopWriting,
                                      child: FaIcon(
                                        FontAwesomeIcons.circleArrowUp,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          cursorColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
