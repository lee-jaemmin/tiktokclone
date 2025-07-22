import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/main_navigation/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = [
    Center(
      child: Text('home'),
    ),
    Center(
      child: Text('Search'),
    ),
    Center(
      child: Text('Search'),
    ),
    Center(
      child: Text('Search'),
    ),
    Center(
      child: Text('Search'),
    ),
  ];

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                myonTap: () => _onTap(0),
              ),
              NavTab(
                text: "Discover",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.magnifyingGlass,
                myonTap: () => _onTap(1),
              ),
              NavTab(
                text: "Inbox",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.inbox,
                myonTap: () => _onTap(3),
              ),
              NavTab(
                text: "Profile",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                myonTap: () => _onTap(4),
              ),
              /*
              정리하자면, 함수를 콜백한다는 전제는 똑같다.
              인자가 없으면 함수 자체를 콜백할 수  있으나 인자를 써버리면 빌드될 때 바로 실행돼서 
              이 경우에는 익명함수에 감싸서 함수 (익명) 내부에서 함수를 실행하는 구조를 만들어버리는 것이다.
              */
            ],
          ),
        ),
      ),
    );
  }
}
