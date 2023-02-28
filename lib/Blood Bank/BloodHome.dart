// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'AllDonorList.dart';
import 'DonorList.dart';

class BloodHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 243, 197, 193),
            endDrawer: Drawer(
              child: Container(
                color: Colors.red.withOpacity(0.65),
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(MdiIcons.doctor),
                      title: const Text(
                        "List All Blood Donor",
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return AllDonorList();
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(color: Colors.black),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              title: const Text('Blood Bank'),
              backgroundColor: Colors.red.withOpacity(0.85),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4.0,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.75),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  //color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Text(
                                    "Welcome, ", //Also add username from Firebase
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 05),
                                  Text(
                                    '${snapshot.data!.docs.first['name']}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //   color: Colors.blue,
                          // ),
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 5,
                            bottom: 30,
                          ),
                          alignment: AlignmentDirectional.centerStart,
                          child: const Text(
                            'Which Blood group are you looking for?',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          //physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.2,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: bloodGroup.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DonorList(
                                        bloodGroup: bloodGroup[index],
                                      );
                                    },
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 231, 55, 55),
                                child: Text(
                                  bloodGroup[index],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

List bloodGroup = [
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-',
];
