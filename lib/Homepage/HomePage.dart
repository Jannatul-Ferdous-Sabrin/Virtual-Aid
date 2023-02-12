import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ionicons/ionicons.dart';
import 'BottomHomePage.dart';
import 'BottomMenuPage.dart';
import 'BottomProfilePage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'BottomSettingPage.dart';

final user = FirebaseAuth.instance.currentUser!;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final BottomPages = [
    BottomHomePage(),
    BottomMenuPage(),
    BottomProfilePage(),
    BottomSettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.notifications_outline),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.search_outline),
          ),
          IconButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                width: 280,
                animType: AnimType.bottomSlide,
                dismissOnTouchOutside: true,
                dismissOnBackKeyPress: false,
                title: 'LOG OUT',
                desc: 'Are You Sure You Want to Log Out?',
                btnCancelOnPress: () {},
                btnOkOnPress: () => FirebaseAuth.instance.signOut(),
              ).show();
            },
            icon: const Icon(Ionicons.exit_outline),
          ),
        ],
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
            icon: Icon(Ionicons.menu_outline),
            label: 'Menu',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            label: 'Profile',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.settings_outline),
            label: 'Setting',
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
