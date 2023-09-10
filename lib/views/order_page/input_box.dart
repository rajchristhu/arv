import 'package:arv/utils/app_colors.dart';
import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    required this.textController,
    required this.labelText,
    required this.hintText,
    required this.isUsername,
    this.isEnabled = true,
  });

  final TextEditingController textController;
  final String labelText;
  final String hintText;
  final bool isUsername;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Center(
        child: TextField(
          enabled: isEnabled,
          controller: textController,
          cursorColor: gray,
          textAlign: TextAlign.left,
          keyboardType: isUsername ? TextInputType.number : null,
          decoration: InputDecoration(
            fillColor: white,
            filled: true,
            border: outlineInputBorder(),
            errorBorder: outlineInputBorder(),
            disabledBorder: outlineInputBorder(),
            focusedBorder: outlineInputBorder(),
            enabledBorder: outlineInputBorder(),
            labelText: labelText,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(
              left: 7.5,
              bottom: 10,
            ),
            hintStyle: TextStyle(
              fontSize: 10.0,
              color: black,
            ),
            labelStyle: TextStyle(
              fontSize: 15.0,
              color: black,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: appColor,
      ),
    );
  }
}
