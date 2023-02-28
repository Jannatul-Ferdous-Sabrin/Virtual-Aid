// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'SignIn.dart';
import 'SignUp.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? SignIn(onClickedSignUp: toogle)
      : SignUp(onClickedSignIn: toogle);

  void toogle() => setState(() => isLogin = !isLogin);
}
