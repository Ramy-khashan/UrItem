import 'package:flutter/material.dart';

class ViewItem extends StatelessWidget {
  const ViewItem({this.data,this.size, Key? key}) : super(key: key);
  final Size? size;

  final String? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size!.longestSide * .013),
      padding: EdgeInsets.all(size!.shortestSide * .05),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade900,
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 9,
              spreadRadius: 3,
            )
          ]),
      child: Text(
        data!,
        style: TextStyle(
            fontSize: size!.shortestSide * .05,
            color: Colors.white,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
