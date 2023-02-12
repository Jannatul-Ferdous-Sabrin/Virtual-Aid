import 'package:flutter/material.dart';
import '../Ambulance/AmbulanceHome.dart';
import '../Blood Bank/BloodHome.dart';
import '../CreateCase/CaseHome.dart';
import '../Doctor Appoinment/HomeScreen.dart';

class BottomHomePage extends StatelessWidget {
  List<FeaturesList> featuresList = [
    FeaturesList('assets/BloodBank.jpg', 'Blood Bank', (context) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BloodHome();
          },
        ),
      );
    }),
    FeaturesList('assets/BloodBank.jpg', 'Doctor Appoinment', (context) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return HomeScreen();
          },
        ),
      );
    }),
    FeaturesList('assets/BloodBank.jpg', 'Create a Case', (context) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return CaseHome();
          },
        ),
      );
    }),
    FeaturesList('assets/BloodBank.jpg', 'Ambulance', (context) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return AmbulanceHome();
          },
        ),
      );
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Fade-in logo of our project added here',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                "Features",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(50),
                              // color: Theme.of(context)
                              //     .colorScheme
                              //     .primaryContainer
                              //     .withOpacity(0.4),
                            ),
                            child: Image.asset(featuresList[index].icon),
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
