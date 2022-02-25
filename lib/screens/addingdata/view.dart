import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uritem/component/buttonitem.dart';
import 'package:uritem/component/textfielditem.dart';
import 'package:uritem/screens/addingdata/controlelr.dart';

import 'states.dart';

class AddingDataScreen extends StatelessWidget {
  final String? title;

  final String? data;

  final String? price;

  final String? docsId;

  final bool? isUpdate;

  const AddingDataScreen(
      {Key? key, this.data, this.isUpdate, this.price, this.docsId, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          AddingDataController()..startValue(isUpdate, title, data, price),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Adding Item",
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
        body: BlocBuilder<AddingDataController, AddingDataState>(
          builder: (context, state) {
            final controller = AddingDataController.get(context);
            return controller.isDone
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.shortestSide * .02,
                              vertical: size.shortestSide * .02),
                          child: TextFieldItem(
                            hint: "Title",
                            onPress: () {},
                            value: controller.titleController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.shortestSide * .02,
                              vertical: size.shortestSide * .025),
                          child: TextFieldItem(
                            hint: "Price",
                            onPress: () {},
                            value: controller.priceController,
                            keybordtype: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.shortestSide * .02,
                              vertical: size.shortestSide * .02),
                          child: TextFieldItem(
                            hint: "Details",
                            onPress: () {
                              if (isUpdate == true) {
                                controller.updateItem(context, docsId);
                              } else {
                                controller.uploadItem(context);
                              }
                            },
                            value: controller.detailsController,
                            line: 5,
                          ),
                        ),
                        SizedBox(height: size.longestSide * .3),
                        ButtonItem(
                          head: "Adding",
                          onTap: () {
                            if (isUpdate == true) {
                              controller.updateItem(context, docsId);
                            } else {
                              controller.uploadItem(context);
                            }
                          },
                          size: size,
                        ),
                        SizedBox(height: size.longestSide * .02),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
