import 'package:flutter/material.dart';
import 'package:tiktokclone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  FormButton({super.key, required this.disabled, required this.text});

  final bool disabled;
  String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 300,
        ),
        padding: EdgeInsets.symmetric(vertical: Sizes.size14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size5),
          color: disabled
              ? Colors.grey.shade300
              : Theme.of(context).primaryColor,
        ),
        child: AnimatedDefaultTextStyle(
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
          ),
          duration: Duration(
            milliseconds: 300,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
