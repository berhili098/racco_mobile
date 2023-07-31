import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SncakBarWidgdet {
  static snackBarAten(BuildContext context, String text) {
    Flushbar(
            message: text,
            flushbarPosition: FlushbarPosition.TOP,
            icon: const Icon(Icons.info_outline,
                size: 28.0, color: Colors.yellow),
            duration: const Duration(seconds: 3),
            leftBarIndicatorColor: Colors.yellow)
        .show(context);
  }

  static snackBarError(BuildContext context, String text) {
    Flushbar(
      message: text,
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.red,
      ),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: Colors.red,
    ).show(context);
  }

  static snackBarSucces(BuildContext context, String text) {
    Flushbar(
      message: text,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor : const Color(0XFF6171ba),
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.white
      ),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: Colors.white,
    ).show(context);
  }
}
