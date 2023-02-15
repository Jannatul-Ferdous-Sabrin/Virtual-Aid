import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AddDoctor extends StatefulWidget {
  @override
  State<AddDoctor> createState() => AddDoctorState();
}

class AddDoctorState extends State<AddDoctor> {
  File? _image;

  pickImage() async {
    final ImagePicker imagePicker = ImagePicker();

    final pickedXFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    final galleryFile = File(pickedXFile!.path);

    // if (galleryFile == null) {
    //   return galleryFile.readAsBytes();
    // } else {
    //   print('No Image Selected');
    // }

    setState(() {
      _image = galleryFile;
    });
  }

  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerHospital = TextEditingController();
  //final controllerSpecialist = TextEditingController();
  final controllerDesciption = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String specialistValue = '                            ';
  String hospitalValue = '                            ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        title: const Text('Add Doctor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
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
            ),
            const SizedBox(height: 10),
            TextFormField(
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
            ),
            const SizedBox(height: 10),
            DropdownButton(
              value: specialistValue,
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
              value: hospitalValue,
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
            CircleAvatar(
              radius: 50,
              backgroundImage: _image != null ? FileImage(_image!) : null,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final doctors = Doctors(
                    name: controllerName.text,
                    age: int.parse(controllerAge.text),
                    hospital: controllerHospital.text,
                    specialist: specialistValue,
                    //userImageFile: _image,
                  );

                  createUser(doctors);

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fields must not be empty'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future createUser(Doctors Doctors) async {
    final docDoctors =
        FirebaseFirestore.instance.collection('DoctorList').doc();
    Doctors.id = docDoctors.id;

    final json = Doctors.toJson();
    await docDoctors.set(json);
  }
}

class Doctors {
  String id;
  final String name;
  final int age;
  final String hospital;
  final String specialist;
  //final File userImageFile;

  Doctors({
    this.id = '',
    required this.name,
    required this.age,
    required this.hospital,
    required this.specialist,
    //required this.userImageFile,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'hospital': hospital,
        'specialist': specialist,
      };
}

List<String> specialistList = [
  '                            ',
  'Heart',
  'Brain',
  'Teeth',
  'Eye',
];

List<String> hospitalList = [
  '                            ',
  'Al-Haramain',
  'IBN-Sina',
  'Heart Foundation',
  'Mount-Adora',
];
