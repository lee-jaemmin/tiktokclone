import 'package:flutter/material.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/onboarding/widgets/interset_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final ScrollController _scrollController = ScrollController();

  bool showTitle = false;

  void _onScroll() {
    // setState 호출 최소화.. 중요!
    final shouldShow = _scrollController.offset > 94;
    if (showTitle != shouldShow) {
      showTitle = !showTitle;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: showTitle ? 1 : 0,
          duration: Duration(
            milliseconds: 300,
          ),
          child: Text(
            "Choose your interests",
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: Sizes.size16,
              left: Sizes.size24,
              right: Sizes.size24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chooses your \n interests",
                  style: TextStyle(
                    fontSize: Sizes.size36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Gaps.v16,
                Text(
                  "Get better video recommends",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                ),
                Gaps.v40,
                Wrap(
                  // 가로로 배치하고 알아서 다음줄로 넘어감.
                  runSpacing: 15,
                  spacing: 15,
                  children: [
                    for (var interest in interests) // 무거우면 ListViewBuilder 써야됨.
                      InterestButton(interest: interest),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          color: Colors.grey.shade50,
          elevation: 10,
          height: 150,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: Sizes.size32,
              top: Sizes.size12,
              left: Sizes.size24,
              right: Sizes.size24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 60,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    "Skip",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Gaps.h16,
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 60,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    "Next",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
