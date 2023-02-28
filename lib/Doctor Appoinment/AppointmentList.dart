// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentList extends StatefulWidget {
  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseAuth.instance.currentUser!.email == 'nimda884@gmail.com'
            ? FirebaseFirestore.instance
                .collection('DoctorAppointment')
                .snapshots()
            : FirebaseFirestore.instance
                .collection('DoctorAppointment')
                .where('userEmail',
                    isEqualTo: FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white60,
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data!.docs[index]['doctorName'],
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.docs[index]['specialistName'],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              snapshot.data!.docs[index]['hospitalName'],
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              DateTime.fromMillisecondsSinceEpoch(snapshot
                                      .data!
                                      .docs[index]['dateTime']
                                      .millisecondsSinceEpoch)
                                  .toLocal()
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (FirebaseAuth.instance.currentUser!.email ==
                          'nimda884@gmail.com')
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Doctor'),
                                    content: const Text(
                                        'Are you sure you want to delete this Appointment?'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Delete'),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('DoctorAppointment')
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
