// ignore_for_file: use_key_in_widget_constructors, file_names, non_constant_identifier_names

import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../snackBar.dart';
import 'AddDonor.dart';

class AllDonorList extends StatefulWidget {
  @override
  State<AllDonorList> createState() => _AllDonorListState();
}

class _AllDonorListState extends State<AllDonorList> {
  late final Stream<QuerySnapshot> _DonorDetailsStream;

  @override
  void initState() {
    super.initState();
    _DonorDetailsStream =
        FirebaseFirestore.instance.collection("DonorList").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 197, 193),
      appBar: AppBar(
        title: const Text("Donor List"),
        backgroundColor: Colors.red.withOpacity(0.85),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _DonorDetailsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "The List is Empty",
                //style: TextStyle(),
              ),
            );
          }
          return Material(
            color: const Color.fromARGB(255, 243, 197, 193),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.docs[index]['name'],
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Age: ${snapshot.data!.docs[index]['age']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  FlutterClipboard.copy(snapshot
                                      .data!.docs[index]["phonenumber"]);
                                  CopiedSnackBar.showSnackBar(context,
                                      'Phone Number copied to Clipboard');
                                },
                                child: Text(
                                  snapshot.data!.docs[index]['phonenumber'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['bloodgroup'],
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.red.withOpacity(0.9)),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  snapshot.data!.docs[index]['location'],
                                  style: const TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (FirebaseAuth.instance.currentUser!.email ==
                              'nimda884@gmail.com')
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Delete Doctor'),
                                        content: const Text(
                                            'Are you sure you want to delete this doctor?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Delete'),
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('DoctorList')
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .delete();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.withOpacity(0.9),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return AddDonor();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
