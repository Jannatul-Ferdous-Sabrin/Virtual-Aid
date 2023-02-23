import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'DonorList.dart';

class BloodHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 197, 193),
      endDrawer: Drawer(
        child: Container(
          color: Colors.red.withOpacity(0.65),
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(MdiIcons.doctor),
                title: const Text(
                  "List All Blood Donor",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
              const Divider(color: Colors.black),
              ListTile(
                leading: const Icon(MdiIcons.note),
                title: const Text(
                  "Dummy",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
              const Divider(color: Colors.black),
              ListTile(
                leading: const Icon(MdiIcons.heart),
                title: const Text(
                  "Dummy",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
              const Divider(color: Colors.black),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Blood Bank'),
        backgroundColor: Colors.red.withOpacity(0.85),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.0,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.75),
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
                              hintText: "   Search for Blood Group......",
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
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 20,
                      bottom: 20,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                    child: const Text(
                      'Which Blood group are you looking for?',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: bloodGroup.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                return DonorList();
                              },
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            bloodGroup[index],
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
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

List bloodGroup = [
  'A+',
  'A-',
  'AB+',
  'AB-',
  'B+',
  'B-',
  'O+',
  'O-',
];
