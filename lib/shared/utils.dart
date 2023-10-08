import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

// ignore: library_private_types_in_public_api
_Utils utils = _Utils.instance;

class _Utils {
  _Utils._();

  static final _Utils instance = _Utils._();

  notify(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade700,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  String getDateString(int timeStamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);

    final DateFormat dateFormat = DateFormat("E, d MMM ''yy , h:mm a");

    return dateFormat.format(dateTime);
  }
}
