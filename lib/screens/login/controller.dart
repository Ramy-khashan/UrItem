import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../homepage/view.dart';
import 'states.dart';

class LoginController extends Cubit<LoginStates> {
  LoginController() : super(InitialLoginState());

  static LoginController get(_) => BlocProvider.of(_);
  bool isShow = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void showPassword() {
    emit(ChangePasswordShowtate());
    isShow = !isShow;
  }

  bool isSubmit = false;

  UserCredential? user;

  Future<void> login(context) async {
    try {
      isSubmit = true;
      emit(LoadingState());
      user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        isSubmit = false;
        emit(SuccessState());
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePageScreen()),
            (route) => false);
        return null;
      });
    } on FirebaseAuthException catch (e) {
      isSubmit = false;
      emit(FailedState());
      if (e.code == 'user-not-found') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('No user found for that email.'),
            )).show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Wrong password provided for that user.'),
            )).show();
      }
    }
  }
}
