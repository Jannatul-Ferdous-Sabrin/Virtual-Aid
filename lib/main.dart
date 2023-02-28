// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Authentication/AuthPage.dart';
import 'Homepage/HomePage.dart';
import 'snackBar.dart';
//import '/Doctor Appoinment/HomeScreen.dart';
//import 'Doctor Appoinment/DoctorDetails.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'VirtualAid',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorSchemeSeed: const Color(0xff5a73d8),
//         textTheme: GoogleFonts.plusJakartaSansTextTheme(
//           Theme.of(context).textTheme,
//         ),
//         //useMaterial3: true,
//       ),
//       home: HomePage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFFD9E4EE),
          textTheme: GoogleFonts.plusJakartaSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: MainPage(),
      );
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              if (user.emailVerified) {
                return HomePage();
              } else {
                return AuthPage();
              }
            } else {
              return AuthPage();
            }
          },
        ),
      );
}
