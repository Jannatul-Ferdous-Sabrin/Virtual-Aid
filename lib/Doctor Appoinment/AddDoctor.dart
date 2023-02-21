import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import '../snackBarController.dart';

class AddDoctor extends StatefulWidget {
  @override
  State<AddDoctor> createState() => AddDoctorState();
}

class AddDoctorState extends State<AddDoctor> {
  late String name;
  late int age;
  late String description;
  late String doctorsID;
  String specialistValue = 'Select Specialist';
  String hospitalValue = 'Select Hospital';

  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerDesciption = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  void pickDoctorImage() async {
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        image = pickedImage!;
      });
    } catch (e) {}
  }

  Widget displayImage() {
    return Image.file(File(image!.path));
  }

  // Future<void> uploadImage() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     if (image != null) {
  //       try {
  //         Reference ref =
  //             _firebaseStorage.ref('DoctorsPhotos/${path.basename}');

  //         await ref.putFile(File(image!.path)).whenComplete(() async {
  //           await ref.getDownloadURL().then((value) {
  //             imageUrlList.add(value);
  //           });
  //         });
  //       } catch (e) {
  //         print(e);
  //       }
  //       setState(() {
  //         image = null;
  //       });
  //       _formKey.currentState!.reset();
  //     } else {
  //       snackBar('Please Pick Image', context);
  //     }
  //   } else {
  //     snackBar('Fields must not be empty', context);
  //   }
  // }

  Future<void> uploadImage() async {
    Reference ref =
        _firebaseStorage.ref('DoctorListPhotos/${path.basename(image!.path)}');

    await ref.putFile(File(image!.path)).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        imageUrlList.add(value);
      });
    });
  }

  void uploadInfo() async {
    CollectionReference infoRef = _firestore.collection('DoctorList');
    doctorsID = const Uuid().v4();

    await infoRef.doc(doctorsID).set({
      'doctors ID': doctorsID,
      'name': name,
      'age': age,
      'description': description,
      'specialist': specialistValue,
      'hospital': hospitalValue,
      'doctorImage': imageUrlList,
    }).whenComplete(() {});
  }

  void uploadDoctorInfo() async {
    await uploadImage().whenComplete(uploadInfo);
  }

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
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Description must not be empty';
                } else {
                  return null;
                }
              },
              maxLength: 100,
              maxLines: 3,
              controller: controllerDesciption,
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
              onChanged: (value) {
                description = value;
              },
            ),
            const SizedBox(height: 10),
            // CircleAvatar(
            //   radius: 50,
            //   backgroundImage: image != null ? FileImage(image) : null,
            // ),
            InkWell(
              onTap: () {
                setState(() {
                  image = null;
                });
              },
              child: Container(
                padding: const EdgeInsetsDirectional.only(top: 60),
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: image != null
                      ? displayImage()
                      : const Text(
                          'You have not pick any image',
                          style: TextStyle(fontSize: 11),
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
                uploadDoctorInfo();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<String> specialistList = [
  'Select Specialist',
  'Heart',
  'Brain',
  'Dental',
  'Eye',
];

List<String> hospitalList = [
  'Select Hospital',
  'Al-Haramain',
  'IBN-Sina',
  'Mount-Adora',
  'Heart Foundation',
];

List<String> imageUrlList = [];
