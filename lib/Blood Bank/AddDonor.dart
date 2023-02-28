// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../snackBar.dart';

class AddDonor extends StatefulWidget {
  @override
  State<AddDonor> createState() => _AddDonorState();
}

class _AddDonorState extends State<AddDonor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerLocation = TextEditingController();

  String? name;
  String? phone;
  String? location;
  int? age;
  String? bloodGroupValue;

  Future<void> uploadDonorList() async {
    if (_formKey.currentState!.validate()) {
      if (bloodGroupValue == null) {
        CustomSnackBar.showSnackBar(context, 'Blood Group must be picked.');
      } else {
        CollectionReference donorRef =
            FirebaseFirestore.instance.collection('DonorList');

        await donorRef.doc().set(
          {
            'name': name,
            'age': age,
            'location': location,
            'phonenumber': phone,
            'bloodgroup': bloodGroupValue,
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
      backgroundColor: const Color.fromARGB(255, 243, 197, 193),
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(0.85),
        title: const Text("Add Donor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Name must not be Empty";
                  }
                },
                controller: controllerName,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Age must not be Empty";
                  }
                },
                controller: controllerAge,
                decoration: const InputDecoration(
                  label: Text("Age"),
                ),
                onChanged: (value) {
                  age = int.parse(value);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Location must not be Empty";
                  }
                },
                controller: controllerLocation,
                decoration: const InputDecoration(
                  label: Text("Location"),
                ),
                onChanged: (value) {
                  location = value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
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
                controller: controllerPhone,
                decoration: const InputDecoration(
                  label: Text("Phone"),
                ),
                onChanged: (value) {
                  phone = value;
                },
              ),
              DropdownButton(
                value: bloodGroupValue,
                hint: const Text("Blood Group"),
                items: bloodGroup.map<DropdownMenuItem<String>>(
                  (e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    bloodGroupValue = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red.withOpacity(0.9),
                    ),
                  ),
                  onPressed: () {
                    uploadDonorList();
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> bloodGroup = [
  'A+',
  'A-',
  'AB+',
  'AB-',
  'B+',
  'B-',
  'O+',
  'O-',
];
