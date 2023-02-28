// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ionicons/ionicons.dart';
import 'BottomEditProfilePage.dart';
import 'BottomHomePage.dart';
import 'BottomMenuPage.dart';
import 'BottomProfilePage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final BottomPages = [
    BottomHomePage(),
    BottomProfilePage(),
    BottomEditProfilePage(),
    BottomMenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
            ),
            Text(
              user.email!,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
      body: BottomPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 20,
        selectedFontSize: 18,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            label: 'Profile',
            backgroundColor: Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.clipboard_outline),
            label: 'Edit Profile',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.menu_outline),
            label: 'Menu',
            backgroundColor: Colors.red,
          ),
        ],
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
    );
  }
}
