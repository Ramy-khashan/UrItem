import 'package:flutter/material.dart';

import 'controller.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  _FlashScreenState createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  final controller = FlashController();
  @override
  void initState() {
    controller.flashScreenTime(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: size.shortestSide * .5,
            ),
            SizedBox(
              height: size.longestSide * .02,
            ),
            Text(
              "Ur Item",
              style: TextStyle(
                fontFamily: "AppBar",
                fontSize: size.shortestSide * .1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
