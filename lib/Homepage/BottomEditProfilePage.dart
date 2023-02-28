// ignore_for_file: use_key_in_widget_constructors, file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../snackBar.dart';

class BottomEditProfilePage extends StatefulWidget {
  @override
  State<BottomEditProfilePage> createState() => _BottomEditProfilePageState();
}

class _BottomEditProfilePageState extends State<BottomEditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  void updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final currentUser = FirebaseAuth.instance.currentUser;
      final email = currentUser!.email;
      final name = _nameController.text;
      final fullName = _fullNameController.text;
      final address = _addressController.text;
      final phoneNumber = _phoneNumberController.text;

      // Find the user document in Firestore using their email
      final userQuery = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();

      // Update the user document with the new information
      final userDoc = userQuery.docs.first;
      userDoc.reference.update({
        'name': name,
        'fullName': fullName,
        'address': address,
        'phoneNumber': phoneNumber,
      });

      // Go back to previous screen
      CopiedSnackBar.showSnackBar(context, 'Updated Successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
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
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
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
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    updateProfile();
                  },
                  child: const Text(
                    'Update',
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
