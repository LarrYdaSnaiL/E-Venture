import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// A reusable helper class to show consistent toast notifications across the app.
class ToastHelper {
  /// Shows a short toast message at the bottom of the screen.
  static void showShortToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withAlpha(204),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

