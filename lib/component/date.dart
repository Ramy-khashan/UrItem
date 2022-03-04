import 'package:flutter/material.dart';

class DateItem extends StatelessWidget {
  const DateItem({this.controller, this.hint, this.size, Key? key})
      : super(key: key);
  final Size? size;
  final String? hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: size!.shortestSide * .02),
        child: TextField(
          style: TextStyle(fontSize: size!.shortestSide * .046),
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              hintText: hint,
              filled: true,
              fillColor: Colors.white),
        ),
      ),
    );
  }
}
