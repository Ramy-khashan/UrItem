import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uritem/screens/addingdata/view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../component/itemshape.dart';
import '../login/view.dart';
import '../viewitem/view.dart';
import 'controller.dart';
import 'state.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomePageController()..getData(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Ur Item",
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
          actions: [
            IconButton(
              tooltip: "Filter",
              icon: const Icon(Icons.filter_list),
              onPressed: () {},
            ),
            IconButton(
                onPressed: () {
                  AwesomeDialog(
                      context: context,
                      body: Column(
                        children: [
                          Text('You want to sign out !',
                              style: TextStyle(
                                  fontSize: size.shortestSide * .047,
                                  fontFamily: "head")),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: const Text(
                                  "Sign out",
                                ),
                                onPressed: () async {
                                  await FirebaseAuth.instance
                                      .signOut()
                                      .then((value) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                        (route) => false);
                                  });
                                },
                              ),
                              SizedBox(width: size.shortestSide * .03),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blueGrey)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cansle",
                                  style: TextStyle(fontFamily: 'button'),
                                ),
                              )
                            ],
                          ),
                        ],
                      )).show();
                },
                icon: Icon(Icons.exit_to_app, size: size.shortestSide * .07))
          ],
        ),
        body: BlocBuilder<HomePageController, HomePageState>(
            builder: (context, state) {
          final controller = HomePageController.get(context);

          return controller.isDoneLoad
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.data.isEmpty
                  ? Center(
                      child: Text(
                        "Empty",
                        style: TextStyle(
                            fontSize: size.shortestSide * .07,
                            color: Colors.grey.shade400),
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
                                          index: i, data: controller.data)));
                            },
                            onDoubleTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddingDataScreen(
                                            isUpdate: true,
                                            title: controller.data[i]['title'],
                                            data: controller.data[i]['data'],
                                            price: controller.data[i]['price'],
                                            docsId: controller.docsId[i],
                                          )));
                            },
                            child: ItemShape(
                              date: controller.data[i]["data"],
                              name: controller.data[i]["title"],
                              price: controller.data[i]["price"],
                            ));
                      },
                      itemCount: controller.data.length,
                    );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddingDataScreen(
                          isUpdate: false,
                        )));
          },
          backgroundColor: Colors.blue.shade700,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
