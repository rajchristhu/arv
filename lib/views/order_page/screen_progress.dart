import 'package:arv/views/order_page/resources.dart';
import 'package:flutter/material.dart';

class ScreenProgress extends StatelessWidget {
  final int ticks;
  BuildContext contexts;

  ScreenProgress({super.key, required this.ticks, required this.contexts});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        tick1(),
        spacer(),
        line(),
        spacer(),
        tick2(),
        spacer(),
        line(),
        spacer(),
        tick3(),
        spacer(),
        line(),
        spacer(),
        tick4(),
      ],
    );
  }

  Widget tick(bool isChecked) {
    return isChecked
        ? Icon(
            Icons.check_circle,
            color: Resources(contexts).color.colorPrimary,
          )
        : Icon(
            Icons.radio_button_unchecked,
            color: Resources(contexts).color.colorPrimary,
          );
  }

  Widget tick1() {
    return this.ticks > 0 ? tick(true) : tick(false);
  }

  Widget tick2() {
    return this.ticks > 1 ? tick(true) : tick(false);
  }

  Widget tick3() {
    return this.ticks > 2 ? tick(true) : tick(false);
  }

  Widget tick4() {
    return this.ticks > 3 ? tick(true) : tick(false);
  }

  Widget spacer() {
    return Container(
      width: 4.0,
    );
  }

  Widget line() {
    return Container(
      color: Resources(contexts).color.colorPrimary,
      height: 5.0,
      width: 50.0,
    );
  }
}
