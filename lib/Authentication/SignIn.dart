// ignore_for_file: file_names, use_key_in_widget_constructors, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../snackBar.dart';
import 'ForgotPassword.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignIn({
    required this.onClickedSignUp,
  });
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool isLoading = false;

  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> logIn(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        CustomSnackBar.showSnackBar(context, 'Verify your email first');
        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-email') {
        CustomSnackBar.showSnackBar(context, 'Invalid Email or Password');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30.0),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Welcome Back!",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Invalid email address.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 7) {
                          return 'Password must be at least 7 characters long';
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ),
                          );
                        },
                        child: const Text("Forgot Password?"),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            logIn(context);
                          }
                        },
                        child: const Text("Log In"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'No Account? ',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignUp,
                              text: 'Sign Up',
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
