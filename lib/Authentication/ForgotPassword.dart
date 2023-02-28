// ignore_for_file: file_names, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../snackBar.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void forgotPassword() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Display a snackbar to inform the user that the password reset email has been sent.
        CopiedSnackBar.showSnackBar(
            context, 'Password reset email sent to $email');
      } catch (error) {
        // Display a snackbar to inform the user that there is no user with the provided email address.
        CustomSnackBar.showSnackBar(context, 'No user found with email $email');
      }
    } else {
      CustomSnackBar.showSnackBar(context, 'Invalid Email or Password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
              const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16.0),
              const Text(
                '      Forgot Your Password?',
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              const SizedBox(height: 30.0),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Enter Your Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            forgotPassword();
                          },
                          icon: const Icon(Icons.email),
                          label: const Text('Submit'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
