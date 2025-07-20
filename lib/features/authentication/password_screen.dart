import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/authentication/birthday_screen.dart';
import 'package:tiktokclone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && (_password.length > 8);
  }

  void _deleteAll() {
    // Password controller 장점
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;

    setState(() {}); // setState이 있어야 빌드가 다시 되고 변경 사항이 적용됨!
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BirthdayScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign up",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v32,
              Text(
                "Create Password",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v32,
              TextField(
                // 비밀번호처럼 보이긔.
                obscureText: _obscureText,
                controller: _passwordController,
                decoration: InputDecoration(
                  suffix: Row(
                    // Row가 최대 공간을 차지하는 걸 막기
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _deleteAll,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade400,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h14,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade400,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              Gaps.v10,
              Text(
                "Yor pass word must have:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                    size: Sizes.size20,
                  ),
                  Gaps.h5,
                  Text("8 to 20 characters"),
                ],
              ),
              Gaps.v4,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                    size: Sizes.size20,
                  ),
                  Gaps.h5,
                  Text("Letters, numbers, and special chracters"),
                ],
              ),
              Gaps.v32,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  text: "Next",
                  disabled: !_isPasswordValid(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
