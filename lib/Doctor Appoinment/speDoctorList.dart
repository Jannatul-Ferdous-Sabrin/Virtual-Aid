import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AddDoctor.dart';
import 'DoctorDetails.dart';

class speDoctorList extends StatefulWidget {
  final String specialistName;
  speDoctorList({required this.specialistName});

  @override
  State<speDoctorList> createState() => _speDoctorListState();
}

class _speDoctorListState extends State<speDoctorList> {
  late final Stream<QuerySnapshot> _DoctorsDetailsStream;

  @override
  void initState() {
    super.initState();
    _DoctorsDetailsStream = FirebaseFirestore.instance
        .collection('DoctorList')
        .where('specialist', isEqualTo: widget.specialistName)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _DoctorsDetailsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "This list is Empty",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return Material(
            color: const Color(0xFFD9E4EE),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetails(
                            doctorDetails: snapshot.data!.docs[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white60,
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              snapshot.data!.docs[index]['doctorImage'][0],
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data!.docs[index]['name'],
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data!.docs[index]['specialist'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data!.docs[index]['hospital'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data!.docs[index]['age'].toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton:
          FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDoctor(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : null,
    );
  }
}
