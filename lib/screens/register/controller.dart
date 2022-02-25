import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../homepage/view.dart';
import 'states.dart';

class RegisterController extends Cubit<RegisterStates> {
  RegisterController() : super(InitialRegisterState());

  static RegisterController get(_) => BlocProvider.of(_);

  bool isShow = true;
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? msg;

  void showPassword() {
    isShow = !isShow;
    emit(ChangePasswordShowtate());
  }

  bool isSubmit = false;

  UserCredential? user;

  Future<void> register(context) async {
    try {
      isSubmit = true;
      emit(LoadingState());
      user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        FirebaseFirestore.instance.collection('users').add({
          'email': emailController.text,
          "name": userNameController.text,
          'uid': FirebaseAuth.instance.currentUser!.uid
        });

        isSubmit = false;
        emit(SuccessState());
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePageScreen()),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      isSubmit = false;
      emit(FailedState());
      if (e.code == 'weak-password') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('The password provided is too weak.'),
            )).show();
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('The account already exists for that email.'),
            )).show();
      }
    }
  }
}
