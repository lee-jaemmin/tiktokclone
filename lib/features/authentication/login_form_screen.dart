import 'package:flutter/material.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/authentication/interest_screen.dart';
import 'package:tiktokclone/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  // Formkey로 유효성 검사, Form의 state접근 가능. unique key임.
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      // <- null: Form객체가 있나 없나 확인.
      if (_formKey.currentState!.validate()) {
        // validate(): 각 Textformfield의 'validator' 확인
        // if 모든 게 null: true, 하나라도 not null: false
        _formKey.currentState!.save();
        //save(): 모든 입력 텍스트에 대해 onSaved 콜백 함수 실행
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InterestScreen(),
          ),
        );
      }
    }

    /* 2. ? 써서 null이면 아무것도 하지 않게 함.
    _formKey.currentState?.validate(); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
        child: GestureDetector(
          onTap: _onSubmitTap,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  validator: (value) {
                    // return null: 정상 , not null 비정상(오류)
                    // value 는 String
                    if (value != null && value.isEmpty) {
                      // 클릭도 안함, 클릭만 함 (입력 x)
                      return "Please write your email";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['Email'] = newValue;
                    }
                  },
                ),
                Gaps.v16,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      // 클릭도 안함, 클릭만 함 (입력 x)
                      return "Please Valid Password";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['password'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                FormButton(
                  disabled: false,
                  text: "Log in",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
