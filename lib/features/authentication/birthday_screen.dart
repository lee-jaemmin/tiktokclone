import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/features/authentication/email_screen.dart';
import 'package:tiktokclone/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  // 최초 날짜를 12년 전으로 설정: 12세 미만 사용 금지
  DateTime maximumDate = DateTime(
    DateTime.now().year - 12,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(maximumDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EmailScreen(),
      ),
    );
  }

  // 반복 작업을 메소드로 정의
  // date 중 년-월-일만 추출하고 이를 텍스트에디팅컨트롤러의 값으로 지정.
  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(' ').first;
    _birthdayController.value = TextEditingValue(text: textDate);
    //_birthdayController.text = textDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Sign up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v20,
            Text(
              "When is your birthday?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v4,
            Text(
              "Your birthday won't be shown publicly.",
              style: TextStyle(color: Colors.grey.shade700),
            ),
            Gaps.v16,
            TextField(
              style: TextStyle(color: Colors.black),
              enabled: false,
              controller: _birthdayController,
              decoration: InputDecoration(
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
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v32,
            GestureDetector(
              onTap: _onNextTap, // ()없으면 onTap일때 실행
              child: FormButton(disabled: false, text: "Next"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        child: CupertinoDatePicker(
          onDateTimeChanged:
              _setTextFieldDate, // 콜백함수: 이벤트 발생 시 호출되는 함수. 다른 함수로 전달되는 함수
          mode: CupertinoDatePickerMode.date, // 날짜만 선택할 수 있게
          maximumDate: maximumDate,
          initialDateTime: maximumDate,
        ),
      ),
    );
  }
}
