import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uritem/screens/addingdata/states.dart';

import '../homepage/view.dart';

class AddingDataController extends Cubit<AddingDataState> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  DateTime time = DateTime.now();

  AddingDataController() : super(InitalAddingDataState());

  static AddingDataController get(context) => BlocProvider.of(context);
  bool isDone = false;

  uploadItem(context) async {
    try {
      isDone = true;
      emit(LoadingState());

      FirebaseFirestore.instance.collection('item').add({
        'title':
            titleController.text.isEmpty ? "" : titleController.text.trim(),
        'data':
            detailsController.text.isEmpty ? "" : detailsController.text.trim(),
        'price':
            priceController.text.isEmpty ? "" : priceController.text.trim(),
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'time': DateFormat.jm().format(DateTime.now()),
        "day": DateTime.now().day,
        "month": DateTime.now().month,
        "year": DateTime.now().year
      }).then((value) {
        isDone = false;
        emit(SuccessState());

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePageScreen()),
            (route) => false);
      });
    } catch (e) {
      isDone = false;
      emit(FailedState());
      AwesomeDialog(
          context: context,
          title: "Error",
          body: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Something went wrong try again.'),
          )).show();
    }
  }

  updateItem(context, docId) async {
    isDone = true;
    emit(LoadingState());

    FirebaseFirestore.instance.collection('item').doc(docId).update({
      'title': titleController.text.isEmpty ? "" : titleController.text.trim(),
      'data':
          detailsController.text.isEmpty ? "" : detailsController.text.trim(),
      'price': priceController.text.isEmpty ? "" : priceController.text.trim(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'time': DateFormat.yMMMEd().format(DateTime.now()),
    }).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePageScreen()),
          (route) => false);
    });
  }

  startValue(isUpdate, title, data, price) {
    if (isUpdate == true) {
      titleController.text = title;
      priceController.text = price;
      detailsController.text = data;
    }
  }
}
