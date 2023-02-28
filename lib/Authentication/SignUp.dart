// ignore_for_file: use_build_context_synchronously, invalid_return_type_for_catch_error, unnecessary_null_comparison, file_names, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../snackBar.dart';

class SignUp extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUp({required this.onClickedSignIn});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _conphoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _usersCollectionRef = FirebaseFirestore.instance.collection('Users');

  bool _obscureText = true;
  bool _conobscureText = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> createAccount() async {
    final formState = _formKey.currentState;
    if (formState != null && formState.validate()) {
      formState.save();
      if (_fullNameController.text.isEmpty ||
          _usernameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _phoneNumberController.text.isEmpty ||
          _addressController.text.isEmpty ||
          _passwordController.text.isEmpty) {
        CustomSnackBar.showSnackBar(context, 'All fields are required.');
      } else {
        // Check if email already exists
        final emailSnapshot = await _usersCollectionRef
            .where('email', isEqualTo: _emailController.text.trim())
            .get();
        if (emailSnapshot.docs.isNotEmpty) {
          CustomSnackBar.showSnackBar(
              context, 'This email is already registered.');
          return;
        }

        // Create new user to database
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (userCredential != null) {
          await userCredential.user!.sendEmailVerification();
          await _usersCollectionRef.doc(userCredential.user!.uid).set(
            {
              'name': _usernameController.text,
              'fullName': _fullNameController.text,
              'email': _emailController.text,
              'phoneNumber': _phoneNumberController.text,
              'address': _addressController.text,
            },
          );
        }
        CopiedSnackBar.showSnackBar(context,
            'Account created successfully. A verification email has been sent to ${_emailController.text}.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40.0),
                  Text(
                    "Welcome to Virtual Aid",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      hintText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Full name is required.';
                      }
                      if (!value.contains(' ')) {
                        return 'Full name should contain a space.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required.';
                      }
                      if (value.length < 4 || value.length > 8) {
                        return 'Username should be between 4 and 8 characters.';
                      }
                      if (!value.contains(RegExp(r'\d'))) {
                        return 'Username should contain at least 1 digit.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email Address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email address is required.';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Invalid email address.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                    ),
                    maxLength: 14,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required.';
                      }
                      if (!value.startsWith('+8801')) {
                        return 'Invalid phone number format. Use +8801XXXXXXXXX';
                      }
                      if (value.length != 14) {
                        return 'Phone number should have 13 characters. Use +8801XXXXXXXXX';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      hintText: 'Address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    //obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                        return 'Password is required.';
                      }
                      if (value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      if (!value.contains(RegExp(r'\d'))) {
                        return 'Password should contain at least 1 digit.';
                      }
                      return null;
                    },
                    obscureText: _obscureText,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    obscureText: _conobscureText,
                    controller: _conphoneNumberController,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _conobscureText = !_conobscureText;
                          });
                        },
                        child: Icon(_conobscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm password is required.';
                      }
                      if (value.trim() != _passwordController.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 110.0),
                    child: ElevatedButton(
                      onPressed: () {
                        createAccount();
                      },
                      child: const Text('Create Account'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already Have an Account? ',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: 'Sign In',
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
