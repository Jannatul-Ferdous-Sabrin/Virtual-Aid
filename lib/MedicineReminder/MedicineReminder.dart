import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AddReminder.dart';

class MedicineReminder extends StatefulWidget {
  @override
  State<MedicineReminder> createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  late Stream<QuerySnapshot> _medReminderStream;

  @override
  void initState() {
    super.initState();
    _medReminderStream = FirebaseFirestore.instance
        .collection('MedicineReminderList')
        .where('userEmail', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 228, 216),
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.75),
        title: const Text("Med"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String choice) {
              if (choice == '1') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReminder(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: '1',
                  child: Text(
                    'Add Reminder',
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _medReminderStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final medName = data[index]['medName'];
              final amount = data[index]['amount'];
              final dateTime = data[index]['dateTime'];
              final days = data[index]['days'];

              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medicine Name: $medName',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('Amount: $amount'),
                    const SizedBox(height: 5),
                    Text('Date and Time: $dateTime'),
                    const SizedBox(height: 5),
                    Text('Days: $days'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
