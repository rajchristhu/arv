import 'package:arv/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressedFn;

  CustomButton(this.text, this.onPressedFn);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
          foregroundColor: MaterialStateProperty.all<Color>(accentColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: gray)
              )
          )
      ),
      onPressed: onPressedFn,
      child: CustomText(
        text: text,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        alignment: Alignment.center,
      ),
    );
  }
}
