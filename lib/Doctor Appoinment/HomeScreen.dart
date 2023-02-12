import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'HospitalDoctorList.dart';

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

  List HospitalsName = [
    'Al-Haramain',
    'IBN-Sina',
    'Mount-Adora',
    'Heart-Foundation',
  ];

  List<Icon> HospitalsIcon = const [
    Icon(MdiIcons.hospitalBoxOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.hospitalBoxOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.hospitalBoxOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.hospitalBoxOutline, color: Colors.blue, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFD9E4EE),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.2,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              //backgroundImage: AssetImage('User Photo from Firebase'),
                            ),
                            IconButton(
                              iconSize: 30,
                              icon: const Icon(Icons.menu),
                              color: Colors.white70,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Welcome,", //Also add username from Firebase
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Doctor Appoinment",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25, bottom: 20),
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
                    alignment: AlignmentDirectional.topStart,
                    child: const Text(
                      'Doctor List  (Special On)',
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
                                  builder: (context) => HospitalDoctorList(),
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
                  const SizedBox(height: 20),
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
                      itemCount: HospitalsName.length,
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
                                            builder: (context) =>
                                                HospitalDoctorList(),
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
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        margin: EdgeInsets.all(8),
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.favorite_border_outlined,
                                            color: Colors.blue,
                                            size: 24,
                                          ),
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
                            HospitalsName[index],
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
