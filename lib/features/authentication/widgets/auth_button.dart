import 'package:flutter/material.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthButton extends StatelessWidget {
  final String
  text; // 외부에서 AuthButton을 어찌 사용하는지 보면 됨. text 라는 String 객체가 파라미터로 쓰임.
  final FaIcon icon;

  const AuthButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      // 버튼이 양 옆으로 꽉 찼으면 좋겠어서 사용
      // 부모의 사이즈에 비례해서 크기를 정함. 1000px의 widthFactor 1 ==> 1000px
      // 여기서는 padding 내부의 column이 부모가 됨.
      widthFactor: 1,
      child: Container(
        padding: EdgeInsets.all(Sizes.size14),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: Sizes.size1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              // icon은 왼쪽으로 밀고 싶어서. Align으로 감쌈.
              alignment: Alignment.centerLeft,
              child: icon,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
