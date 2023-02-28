// ignore_for_file: file_names, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'RequestedAppointments.dart';
import 'SearchList.dart';
import 'AppointmentList.dart';
import 'AllDoctorList.dart';
import 'speDoctorList.dart';
import 'HosDoctorList.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List specialistName = [
    'Dental',
    'Heart',
    'Eye',
    'Brain',
  ];

  List<Icon> specialistIcon = const [
    Icon(MdiIcons.toothOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.heartPulse, color: Colors.blue, size: 30),
    Icon(MdiIcons.eyeCheckOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.brain, color: Colors.blue, size: 30),
  ];

  List hospitalsName = [
    'Al-Haramain',
    'IBN-Sina',
    'Mount-Adora',
    'Heart-Foundation',
  ];

  List hospitalPhotos = [
    'assets/alharamainhospital.jpg',
    'assets/IBN-Sina.jpg',
    'assets/MountAdora.jpg',
    'assets/Heart Foundation.jpg',
  ];

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
          backgroundColor: const Color(0xFFD9E4EE),
          endDrawer: Drawer(
            child: Container(
              color: Colors.blue.withOpacity(0.8),
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(MdiIcons.doctor),
                    title: const Text(
                      "List All Doctors",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllDoctorList(),
                        ),
                      );
                    },
                  ),
                  const Divider(color: Colors.black),
                  ListTile(
                    leading: const Icon(MdiIcons.note),
                    title: const Text(
                      "Your Appointments",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentList(),
                        ),
                      );
                    },
                  ),
                  if (FirebaseAuth.instance.currentUser!.email ==
                      'nimda884@gmail.com')
                    ListTile(
                      leading: const Icon(MdiIcons.heart),
                      title: const Text(
                        "Requested Appointments",
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return RequestedAppointment();
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
            title: const Text('Doctor Appointment'),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 59, 112, 161),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
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
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  "Welcome,", //Also add username from Firebase
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  '${snapshot.data!.docs.first['name']}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset: const Offset(300, 0),
                              child: IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchList(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  MdiIcons.magnify,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.blue,
                        // ),
                        padding: const EdgeInsets.only(left: 10),
                        alignment: AlignmentDirectional.centerStart,
                        child: const Text(
                          'Doctor List  (Special On)',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.blue,
                        // ),
                        height: 125,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: specialistName.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => speDoctorList(
                                          specialistName:
                                              specialistName[index]),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 15,
                                  ),
                                  height: 80,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    color: Colors.white24,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: specialistIcon[index],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                specialistName[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.blue,
                        // ),
                        padding: const EdgeInsets.only(left: 10),
                        alignment: AlignmentDirectional.topStart,
                        child: const Text(
                          'Doctor List  (According to Hospital)',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.blue,
                        // ),
                        height: 229,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: hospitalsName.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                height: 160,
                                width: 160,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF2F8FF),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HosDoctorList(
                                                  hospitalsName:
                                                      hospitalsName[index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                            child: Image.asset(
                                              hospitalPhotos[index],
                                              height: 160,
                                              width: 160,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                hospitalsName[index],
                                style: const TextStyle(
                                  fontSize: 14,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
