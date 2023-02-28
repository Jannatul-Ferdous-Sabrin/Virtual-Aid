// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../snackBar.dart';

class AddAmbulance extends StatefulWidget {
  @override
  _AddAmbulanceState createState() => _AddAmbulanceState();
}

class _AddAmbulanceState extends State<AddAmbulance> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //formkey for collecting the formdata
  final TextEditingController controllerName = TextEditingController(); //
  final TextEditingController controlleremail =
      TextEditingController(); //  controller for TextFromField
  final TextEditingController controllerlocation = TextEditingController();
  final TextEditingController controllernumber = TextEditingController();
  String? name; //
  String? email; //
  String? typeValue; //  Variable for storing the data taken from user
  String? number; //
  String? location; //

  Future<void> uploadAmbulance() async {
    if (_formKey.currentState!.validate()) {
      if (typeValue == null) {
        CustomSnackBar.showSnackBar(context, 'Type must be picked.');
      } else {
        CollectionReference donorRef =
            FirebaseFirestore.instance.collection('AmbulanceList');

        await donorRef.doc().set(
          {
            'name': name,
            'email': email,
            'location': location,
            'phoneNumber': number,
            'type': typeValue,
          },
        );
      }
    } else {
      CustomSnackBar.showSnackBar(context, 'All fields must not be empty.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 196, 204),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 138, 168),
        title: const Text('Add Doctor'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Name must not be empty';
                } else {
                  return null;
                }
              },
              controller: controllerName,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              onChanged: (value) {
                name = value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email address is required.';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Invalid email address.';
                }
                return null;
              },
              controller: controlleremail,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Number must not be empty';
                } else {
                  return null;
                }
              },
              controller: controllernumber,
              decoration: const InputDecoration(
                label: Text('Contact Number'),
              ),
              onChanged: (value) {
                number = value;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Location must not be empty';
                } else {
                  return null;
                }
              },
              controller: controllerlocation,
              decoration: const InputDecoration(
                label: Text('Location'),
              ),
              onChanged: (value) {
                location = value;
              },
            ),
            const SizedBox(height: 10),
            DropdownButton(
              borderRadius: BorderRadius.circular(30),
              value: typeValue,
              hint: const Text("Select Type"),
              items: type.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  typeValue = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                uploadAmbulance();
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<String> type = [
  'Private',
  'Hospital',
];
