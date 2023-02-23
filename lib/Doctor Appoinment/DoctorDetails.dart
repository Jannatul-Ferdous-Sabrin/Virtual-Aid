import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DoctorDetails extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> doctorDetails;

  const DoctorDetails({
    required this.doctorDetails,
  });

  void saveAppointment(DateTime selectedDateTime, String doctorName,
      String hospitalName, String specialistName) {
    // Get the current user's email address
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail != null) {
      // Create a new document in the DoctorAppointment collection with the appointment information
      FirebaseFirestore.instance
          .collection('DoctorAppointment')
          .add({
            'dateTime': selectedDateTime,
            'doctorName': doctorName,
            'hospitalName': hospitalName,
            'specialistName': specialistName,
            'userEmail': userEmail,
          })
          .then((value) => print("Appointment saved"))
          .catchError((error) => print("Failed to save appointment: $error"));
    }
  }

  appointmentPicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          if (selectedTime != null) {
            DateTime selectedDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            print('Selected date and time: $selectedDateTime');

            saveAppointment(selectedDateTime, doctorDetails['name'],
                doctorDetails['hospital'], doctorDetails['specialist']);

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: const Color(0xFFD9E4EE),
                  title: const Text('Appointment Booked'),
                  content: Text(
                      'Your appointment has been booked for $selectedDateTime'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFD9E4EE),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: 20.0), // Add some bottom padding here
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      doctorDetails['doctorImage'],
                    ),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            doctorDetails['name'],
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Age: ',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                doctorDetails['age'].toString(),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            doctorDetails['hospital'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Experience: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                doctorDetails['age'].toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        doctorDetails['specialist'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        doctorDetails['description'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Align(
                  //alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      appointmentPicker(context);
                    },
                    child: const Text('Book Appointment'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
