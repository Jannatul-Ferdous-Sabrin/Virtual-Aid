// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../snackBar.dart';

class RequestedAppointment extends StatefulWidget {
  @override
  State<RequestedAppointment> createState() => _RequestedAppointmentState();
}

class _RequestedAppointmentState extends State<RequestedAppointment> {
  void assignDoctor(DocumentSnapshot appointmentSnapshot) {
    // Get appointment data from the snapshot
    Map<String, dynamic> appointmentData =
        appointmentSnapshot.data() as Map<String, dynamic>;

    // Add the appointment data to the DoctorAppointment collection
    FirebaseFirestore.instance.collection('DoctorAppointment').add({
      'dateTime': appointmentData['dateTime'],
      'doctorName': appointmentData['doctorName'],
      'hospitalName': appointmentData['hospitalName'],
      'specialistName': appointmentData['specialistName'],
      'userEmail': appointmentData['userEmail'],
    }).then(
      (value) {
        // Delete the appointment from RequestAppointment
        FirebaseFirestore.instance
            .collection('RequestAppointment')
            .doc(appointmentSnapshot.id)
            .delete()
            .then(
          (value) {
            Navigator.of(context).pop();
            CustomSnackBar.showSnackBar(context, 'Doctor Assigned');
          },
        ).catchError(
          (error) {
            CustomSnackBar.showSnackBar(
                context, 'Failed to delete appointment: $error');
          },
        );
      },
    ).catchError(
      (error) {
        CustomSnackBar.showSnackBar(
            context, 'Failed to add appointment to DoctorAppointment: $error');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('RequestAppointment')
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
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Assign Doctor'),
                                  content: const Text(
                                      'Are you sure you want to asign this doctor?'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Asign'),
                                      onPressed: () {
                                        assignDoctor(
                                            snapshot.data!.docs[index]);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.check),
                        ),
                      ),
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
                                      'Are you sure you want to delete this doctor?'),
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
                                            .collection('RequestAppointment')
                                            .doc(snapshot.data!.docs[index].id)
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
