import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.myonTap,
    required this.selectedIcon,
  });

  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function myonTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // 어디를 눌러도 실행되게!
      child: GestureDetector(
        onTap: () => myonTap(),
        /*
        onTap은 정확히 void Function() 타입의 함수를 기대함
        Function은 추상적이므로 명확한 타입이 아니고, 타입 검사에 실패할 수 있음
        () => ... 형태의 익명 함수는 Dart가 void Function()으로 추론해줌 → 전달 가능
        */

        /*
         익명 함수에 감쌌으므로 우리가 직접 실행해야돼서 onTap이 아닌 onTap()으로.
         인자가 있을 때 () => onTap(1)이런식으로 했지? 이것도 ()를 붙여서 직접 실행해준 것에 해당
        */
        child: Container(
          color: Colors.black,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 100),
            opacity: isSelected ? 1 : 0.5,
            child: Column(
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: Colors.white,
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
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
