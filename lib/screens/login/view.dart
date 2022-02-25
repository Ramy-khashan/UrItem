import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uritem/classes/validation.dart';
import 'package:uritem/component/buttonitem.dart';
import 'package:uritem/component/textfielditem.dart';
import 'package:uritem/screens/register/view.dart';

import 'controller.dart';
import 'states.dart';

class LoginScreen extends StatelessWidget {
  Validation validation = Validation();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginController(),
      child: BlocConsumer<LoginController, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final controller = LoginController.get(context);
          return Scaffold(
            body: controller.isSubmit
                ? const Center(
              child: CircularProgressIndicator(),
            )
                :  Form(
              key: validation.formKey,
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: size.shortestSide * .035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: size.longestSide * .17,
                    ),
                    Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: size.shortestSide * .135,
                          fontFamily: "AppBar",
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.longestSide * .08,
                    ),
                    TextFieldItem(
                      validtion: (val) => validation.email(val),
                      hint: "Email",
                      keybordtype: TextInputType.emailAddress,
                      value: controller.emailController,
                    ),
                    SizedBox(height: size.longestSide * .03),
                    TextFieldItem(
                      validtion: (val) => validation.password(val),
                      onPress: () => controller.showPassword(),
                      isSecure: controller.isShow,
                      isPassword: true,
                      hint: "Password",
                      keybordtype: TextInputType.visiblePassword,
                      value: controller.passwordController,
                    ),
                    SizedBox(height: size.longestSide * .1),
                    ButtonItem(
                      head: "Login",
                      size: size,
                      onTap: () {
                        if (validation.formKey.currentState!.validate()) {
                          controller.login(context);
                        }
                      },
                    ),
                    SizedBox(height: size.longestSide * .02),
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: "Don't have an account yet? "),
                        WidgetSpan(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                                (route) => false);
                          },
                          child: Text("Register",
                              style: TextStyle(
                                  fontSize: size.shortestSide * .042,
                                  color: Colors.blue.shade500,
                                  fontWeight: FontWeight.w900)),
                        ))
                      ]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.longestSide * .03),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
