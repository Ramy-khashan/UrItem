import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uritem/screens/homepage/view.dart';
import 'state.dart';

class HomePageController extends Cubit<HomePageState> {
  HomePageController() : super(InitialState());

  static HomePageController get(context) => BlocProvider.of(context);
  bool isDoneLoad = false;
  List data = [];
  List docsId = [];

  getData() async {
    try {
      isDoneLoad = true;
      emit(LoadingHomeState());
      FirebaseFirestore.instance
          .collection('item')
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        for (var element in value.docs) {
          docsId.add(element.id);

          data.add(element);
        }

        isDoneLoad = false;
        emit(SuccessState());
      });
    } catch (e) {
      isDoneLoad = false;
      emit(FailedState());
    }
  }

  deleteItem(context, index, size) {
    AwesomeDialog(
        context: context,
        dismissOnTouchOutside: false,
        body: Column(
          children: [
            Text("You want to delete this note?",
                style: TextStyle(
                    fontSize: size.shortestSide * .047, fontFamily: "head")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("item")
                          .doc(docsId[index])
                          .delete()
                          .then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePageScreen()),
                            (route) => false);
                      });
                    },
                    child: const Text(
                      "Ok",
                      style: TextStyle(fontFamily: 'button'),
                    )),
                SizedBox(width: size.shortestSide * .03),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey)),
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
  }
}
