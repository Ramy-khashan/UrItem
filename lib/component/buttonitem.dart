import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {
  const ButtonItem({this.size, this.head, this.onTap, Key? key})
      : super(key: key);
  final Size? size;
  final Function()? onTap;
  final String? head;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size!.shortestSide * .07),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            head!,
            style: TextStyle(
                fontSize: size!.shortestSide * .065, fontFamily: "button"),
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              vertical: size!.longestSide * .025,
            )),
          ),
        ),
      ),
    );
  }
}
