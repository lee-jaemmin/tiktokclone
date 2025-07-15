import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/authentication/email_screen.dart';
import 'package:tiktokclone/features/authentication/log_in_screen.dart';
import 'package:tiktokclone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  // action을 위해서는 여기 함수 선언 (1번)
  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      // MateiralApp에는 Navigator 자동 포함
      MaterialPageRoute(
        // builder: 새 페이지 생성하는 함수
        builder: (context) => LoginScreen(),
        // context: LoginScreen의 위치. 그 위치에 loginscreen을 부른다는 뜻.
      ),
    );
  }

  void _onEmailTap(BuildContext context) {
    // _ 는 private을 의미
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EmailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 반드시 필요
      body: SafeArea(
        // '이 안에는 child가 있게 된다'고 보장
        child: Padding(
          // 화면 전체 수평 padding 설정
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                'Sign up for TikTok',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Text(
                'Create a profile, follow other accounts, make your owwn videos, and more',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black45,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () => _onEmailTap(context),
                child: AuthButton(
                  text: "Use email & password",
                  icon: FaIcon(FontAwesomeIcons.user),
                ),
              ),
              Gaps.v16,

              AuthButton(
                text: "Continue with Apple ",
                icon: FaIcon(FontAwesomeIcons.apple),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?'),
              Gaps.h10,
              GestureDetector(
                onTap: () => _onLoginTap(context),
                // (); 익명함수. onTap이 매개변수 없는 함수를 기대하는데, onLoginTap은 매개변수가  있음.
                // 익명 함수로 감싸줘야 이벤트 리스너로써 동작함.
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
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
