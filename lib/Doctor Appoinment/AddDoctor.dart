// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../snackBar.dart';

class AddDoctor extends StatefulWidget {
  @override
  _AddDoctorState createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //formkey for collecting the formdata
  final TextEditingController controllerName = TextEditingController(); //
  final TextEditingController controllerAge =
      TextEditingController(); //  controller for TextFromField
  final TextEditingController controllerDescription =
      TextEditingController(); //
  String? name; //
  int? age; //
  String? specialistValue; //  Variable for storing the data taken from user
  String? hospitalValue; //
  String? description; //
  File? _image; //
  String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

  //ImagePicker Function
  Future pickDoctorImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //Display the image if image is selected
  Widget displayImage() {
    return CircleAvatar(
      radius: 60,
      backgroundImage: FileImage(_image!),
    );
  }

  //Upload doctor image to Firebase Storage
  Future<String> uploadDoctorImage() async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('DoctorPhotos/$uniqueName');
    UploadTask uploadTask = storageReference.putFile(_image!);
    await uploadTask.whenComplete(() => null);
    String doctorImageUrl = await storageReference.getDownloadURL();
    return doctorImageUrl;
  }

// Uplaod doctor info to Firestore Database
  Future<void> uploadDoctorInfo(String imageUrl) async {
    FirebaseFirestore.instance.collection('DoctorList').doc().set(
      {
        'name': name,
        'age': age,
        'specialist': specialistValue,
        'hospital': hospitalValue,
        'description': description,
        'doctorImage': imageUrl,
      },
    );
  }

  Future<void> uploadDoctorData() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Alert'),
            content: const Text('Please pick an image.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (specialistValue == null || hospitalValue == null) {
        CustomSnackBar.showSnackBar(
            context, 'Both Specialist and Hospital have to be selected.');
      } else {
        try {
          String imageUrl = await uploadDoctorImage(); // First upload the image
          await uploadDoctorInfo(imageUrl); // Then upload the doctor info
        } catch (error) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Alert'),
              content:
                  const Text('Something went wrong. Please try again later.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        }
      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
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
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Age must not be empty';
                } else {
                  return null;
                }
              },
              controller: controllerAge,
              decoration: const InputDecoration(
                label: Text('Age'),
              ),
              onChanged: (value) {
                age = int.parse(value);
              },
            ),
            const SizedBox(height: 10),
            DropdownButton(
              borderRadius: BorderRadius.circular(30),
              value: specialistValue,
              hint: const Text("Select Specialist"),
              items: specialistList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  specialistValue = value!;
                });
              },
            ),
            DropdownButton(
              borderRadius: BorderRadius.circular(30),
              value: hospitalValue,
              hint: const Text("Select Hospital"),
              items: hospitalList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  hospitalValue = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Description must not be empty';
                } else {
                  return null;
                }
              },
              maxLength: 100,
              maxLines: 3,
              controller: controllerDescription,
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
              onChanged: (value) {
                description = value;
              },
            ),
            const SizedBox(height: 10),
            InkWell(
              onLongPress: () {
                setState(() {
                  _image = null;
                });
              },
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.blue,
                child: Center(
                  child: _image != null
                      ? displayImage()
                      : const Text(
                          'You have not picked any image',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                pickDoctorImage();
              },
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                uploadDoctorData();
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<String> specialistList = [
  'Heart',
  'Brain',
  'Dental',
  'Eye',
];

List<String> hospitalList = [
  'Al-Haramain',
  'IBN-Sina',
  'Mount-Adora',
  'Heart-Foundation',
];
