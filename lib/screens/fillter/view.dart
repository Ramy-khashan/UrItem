import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uritem/screens/fillter/controller.dart';
import 'package:uritem/screens/fillter/states.dart';

import '../../component/date.dart';
import '../../component/itemshape.dart';
import '../addingdata/view.dart';
import '../viewitem/view.dart';

class FillterScreen extends StatelessWidget {
  const FillterScreen({this.data, this.dataId, Key? key}) : super(key: key);
  final List? data;
  final List? dataId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => FillterController(),
      child: BlocBuilder<FillterController, FilterStates>(
        builder: (context, state) {
          final controller = FillterController.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  "Filter",
                  style: TextStyle(
                    fontFamily: "AppBar",
                    fontSize: size.shortestSide * .07,
                  ),
                ),
              ),
              toolbarHeight: size.longestSide * .11,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.grey.shade800, Colors.blue.shade900])),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Center(
                              child: Text(
                            "Enter The Date",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: size.shortestSide * .055,
                                fontWeight: FontWeight.w600),
                          )),
                          content: SizedBox(
                            child: Row(children: [
                              DateItem(
                                size: size,
                                controller: controller.dayController,
                                hint: controller.hint[0],
                              ),
                              DateItem(
                                size: size,
                                controller: controller.monthController,
                                hint: controller.hint[1],
                              ),
                              DateItem(
                                size: size,
                                controller: controller.yearController,
                                hint: controller.hint[2],
                              )
                            ]),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                controller.fillterData.clear();
                                controller.fillterDataId.clear();
                                controller.filter(data, dataId);

                                Navigator.pop(context);
                                controller.dayController.clear();
                                controller.monthController.clear();
                                controller.yearController.clear();
                              },
                              child: Text("Filter",
                                  style: TextStyle(
                                    fontSize: size.shortestSide * .05,
                                  )),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel",
                                    style: TextStyle(
                                      fontSize: size.shortestSide * .05,
                                    )))
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: size.shortestSide * .075,
                    ))
              ],
            ),
            body: controller.isfillter == false
                ? Center(
                    child: Text(
                    "Enter The Date",
                    style: TextStyle(
                        fontSize: size.shortestSide * .07,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic),
                  ))
                : controller.isfillter == true && controller.fillterData.isEmpty
                    ? Center(
                        child: Text(
                          "Enter The Date Correct...",
                          style: TextStyle(
                              fontSize: size.shortestSide * .07,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewItemScreen(
                                      index: i, data: controller.fillterData),
                                ),
                              );
                            },
                            onDoubleTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddingDataScreen(
                                            isUpdate: true,
                                            title: controller.fillterData[i]
                                                ['title'],
                                            data: controller.fillterData[i]
                                                ['data'],
                                            price: controller.fillterData[i]
                                                ['price'],
                                            docsId: controller.fillterDataId[i],
                                          )));
                            },
                            child: ItemShape(
                              date: controller.fillterData[i]["data"],
                              name: controller.fillterData[i]["title"],
                              price: controller.fillterData[i]["price"],
                            ),
                          );
                        },
                        itemCount: controller.fillterData.length,
                      ),
          );
        },
      ),
    );
  }
}
