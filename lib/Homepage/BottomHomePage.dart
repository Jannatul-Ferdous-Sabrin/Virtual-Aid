// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../Ambulance/AmbulanceHome.dart';
import '../Blood Bank/BloodHome.dart';
import '../MedicineReminder/MedicineReminder.dart';
import '../Doctor Appoinment/HomeScreen.dart';

class BottomHomePage extends StatelessWidget {
  List<FeaturesList> featuresList = [
    FeaturesList(
      'assets/blood-bank-dir.png',
      'Blood Bank',
      (context) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return BloodHome();
            },
          ),
        );
      },
    ),
    FeaturesList(
      'assets/medical-appointment.png',
      'Doctor Appoinment',
      (context) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return HomeScreen();
            },
          ),
        );
      },
    ),
    FeaturesList(
      'assets/medicinereminder.png',
      'Medicine Reminder',
      (context) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return MedicineReminder();
            },
          ),
        );
      },
    ),
    FeaturesList(
      'assets/ambulance.png',
      'Ambulance',
      (context) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return AmbulanceHome();
            },
          ),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF3B8EF7),
                              Color(0xFFA7BFE8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Virtual Aid',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Features",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    featuresList.length,
                    (index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () =>
                                featuresList[index].features.call(context),
                            child: Container(
                              width: 150,
                              height: 150,
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Image.asset(
                                featuresList[index].icon,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(featuresList[index].name),
                        ],
                      );
                    },
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

class FeaturesList {
  final String icon;
  final String name;
  final Function(BuildContext) features;

  FeaturesList(
    this.icon,
    this.name,
    this.features,
  );
}
