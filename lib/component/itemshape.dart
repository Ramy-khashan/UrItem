import 'package:flutter/material.dart';
class ItemShape extends StatelessWidget {
  const ItemShape({this.name, this.date, this.price, Key? key})
      : super(key: key);
  final String? name;

  final String? date;

  final String? price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: size.shortestSide * .09,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FittedBox(
              child: Text(
                "$price\$",
                style: TextStyle(
                    fontSize: size.shortestSide * .05,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        title: Text(
          "$name",
          style: TextStyle(fontSize: size.shortestSide * .05),
        ),
        subtitle: Text(
          "$date",
          style: TextStyle(
            fontSize: size.shortestSide * .035,
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
