// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, file_names
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomMenuPage extends StatefulWidget {
  @override
  _BottomMenuPageState createState() => _BottomMenuPageState();
}

class _BottomMenuPageState extends State<BottomMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
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
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('About'),
                      content: const Text(
                          'Virtual Aid is a mobile application designed to provide essential medical assistance to people in need. With features like Doctor Appointment, Blood Bank, Medicine Reminder & Ambulance List, and an authentication process using email, the app aims to simplify the process of accessing healthcare. \n\nThe project was developed using mobile application development tools and user research, resulting in successful user testing and positive user feedback. Virtual Aid is a valuable resource for individuals seeking efficient and convenient healthcare services, improving access to medical assistance and providing reliable healthcare solutions.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Got It'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('Contact Admin'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('About'),
                      content: const Text(
                          'This is some dummy text.asdassssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Got It'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  width: 300,
                  animType: AnimType.bottomSlide,
                  dismissOnTouchOutside: true,
                  dismissOnBackKeyPress: false,
                  title: 'LOG OUT',
                  desc: 'Are You Sure You Want to Log Out?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () => FirebaseAuth.instance.signOut(),
                ).show();
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Exit'),
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  width: 300,
                  animType: AnimType.bottomSlide,
                  dismissOnTouchOutside: true,
                  dismissOnBackKeyPress: false,
                  title: 'Exit',
                  desc: 'Are You Sure You Want to Exit?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () => exit(0),
                ).show();
              },
            ),
          ],
        ),
      ),
    );
  }
}
