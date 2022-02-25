import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/viewitem.dart';
import 'controller.dart';
import 'state.dart';

class ViewItemScreen extends StatelessWidget {
  final List? data;
  final int? index;
  const ViewItemScreen({this.index, this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ViewItemController(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Item",
              style: TextStyle(
                fontFamily: "AppBar",
                fontSize: size.shortestSide * .07,
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey.shade800, Colors.blue.shade900])),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.shortestSide * .02),
          child: BlocBuilder<ViewItemController, ViewItemStates>(
            builder: (context, state) {
              final controller = ViewItemController.get(context);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ViewItem(
                    size: size,
                    data: data![index!]["title"],
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: ViewItem(
                            size: size,
                            data: data![index!]["price"],
                          ),
                        ),
                        SizedBox(
                          width: size.shortestSide * .03,
                        ),
                        Expanded(
                          child: ViewItem(
                            size: size,
                            data: data![index!]["time"],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ViewItem(
                    size: size,
                    data: data![index!]["data"],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
