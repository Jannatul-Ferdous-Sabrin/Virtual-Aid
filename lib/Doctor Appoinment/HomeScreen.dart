import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'AppointmentList.dart';
import 'AllDoctorList.dart';
import 'speDoctorList.dart';
import 'HosDoctorList.dart';

class HomeScreen extends StatelessWidget {
  List specialistName = [
    'Dental',
    'Heart',
    'Eye',
    'Brain',
  ];

  List<Icon> specialistIcon = const [
    Icon(MdiIcons.toothOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.heartPulse, color: Colors.blue, size: 30),
    Icon(MdiIcons.eyeCheckOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.brain, color: Colors.blue, size: 30),
  ];

  List hospitalsName = [
    'Al-Haramain',
    'IBN-Sina',
    'Mount-Adora',
    'Heart-Foundation',
  ];

  List<Icon> hospitalsIcon = const [
    Icon(MdiIcons.hospitalBoxOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.hospitalBoxOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.hospitalBoxOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.hospitalBoxOutline, color: Colors.blue, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        title: const Text('Doctor Appointment'),
        actions: [
          PopupMenuButton<int>(
            color: const Color.fromARGB(255, 204, 200, 200),
            icon: const Icon(Icons.menu),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('List All Doctors'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Your Appointments'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Favorites Doctors'),
              ),
            ],
            onSelected: (int value) {
              if (value == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllDoctorList()),
                );
              }
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentList()),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          //backgroundImage: AssetImage('User Photo from Firebase'),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text(
                              "Welcome,", //Also add username from Firebase
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              user.email!,
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "   Search for Doctors......",
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.blue,
                    // ),
                    padding: const EdgeInsets.only(left: 10),
                    alignment: AlignmentDirectional.centerStart,
                    child: const Text(
                      'Doctor List  (Special On)',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.blue,
                    // ),
                    height: 125,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: specialistName.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => speDoctorList(
                                      specialistName: specialistName[index]),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Colors.white24,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: specialistIcon[index],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            specialistName[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.blue,
                    // ),
                    padding: const EdgeInsets.only(left: 10),
                    alignment: AlignmentDirectional.topStart,
                    child: const Text(
                      'Doctor List  (According to Hospital)',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.blue,
                    // ),
                    height: 229,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: hospitalsName.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            height: 160,
                            width: 160,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF2F8FF),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HosDoctorList(
                                                hospitalsName:
                                                    hospitalsName[index]),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        child: Image.asset(
                                          'assets/alharamainhospital.jpg',
                                          height: 160,
                                          width: 160,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            hospitalsName[index],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
