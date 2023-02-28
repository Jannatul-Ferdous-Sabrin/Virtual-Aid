// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AddAmbulance.dart';
import 'AllAmbulance.dart';
import 'HospitalAmbulance.dart';
import 'PrivateAmbulance.dart';

class AmbulanceHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 105, 138, 168),
          title: const Text('Ambulance'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (String choice) {
                if (choice == '1') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAmbulance(),
                    ),
                  );
                }
                if (choice == '2') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllAmbulance(),
                    ),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  if (FirebaseAuth.instance.currentUser!.email ==
                      'nimda884@gmail.com')
                    const PopupMenuItem<String>(
                      value: '1',
                      child: Text(
                        'Add Ambulance',
                      ),
                    ),
                  const PopupMenuItem<String>(
                    value: '2',
                    child: Text(
                      'All Ambulance List',
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 155, 191, 224),
              child: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.car_rental,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.local_hospital,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PrivateAmbulance(),
                  HospitalAmbulance(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
