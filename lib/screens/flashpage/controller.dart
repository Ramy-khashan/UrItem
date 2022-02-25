import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uritem/screens/register/view.dart';

class FlashController {
  void flashScreenTime(context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterScreen(),
            ),
            (route) => false));
  }
}
