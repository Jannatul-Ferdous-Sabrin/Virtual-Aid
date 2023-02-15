import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AddDoctor.dart';
import 'DoctorDetails.dart';

class HospitalDoctorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        title: const Text('Doctor List'),
      ),
      body: StreamBuilder<List<Doctors>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final doctors = snapshot.data!;
              return ListView(
                children: doctors
                    .map((doctors) => buildDoctors(context, doctors))
                    .toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDoctor(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildDoctors(BuildContext context, Doctors doctors) =>
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetails(),
                ),
              );
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white60,
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    'assets/PKC-Pics_0.jpg',
                    height: double.infinity,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        (doctors.name),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        doctors.specialist,
                        style: const TextStyle(
                          fontSize: 20,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        doctors.hospital,
                        style: const TextStyle(
                          fontSize: 20,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${doctors.age}',
                        style: const TextStyle(
                          fontSize: 20,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Stream<List<Doctors>> readUsers() => FirebaseFirestore.instance
      .collection('DoctorList')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Doctors.fromJson(doc.data())).toList());
}

class Doctors {
  String id;
  final String name;
  final int age;
  final String hospital;
  final String specialist;

  Doctors({
    this.id = '',
    required this.name,
    required this.age,
    required this.hospital,
    required this.specialist,
  });

  static Doctors fromJson(Map<String, dynamic> json) => Doctors(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        hospital: json['hospital'],
        specialist: json['specialist'],
      );
}
