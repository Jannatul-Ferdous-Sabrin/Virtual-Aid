// ignore_for_file: use_key_in_widget_constructors, file_names, non_constant_identifier_names

import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../snackBar.dart';

class PrivateAmbulance extends StatefulWidget {
  @override
  State<PrivateAmbulance> createState() => _PrivateAmbulanceState();
}

class _PrivateAmbulanceState extends State<PrivateAmbulance> {
  late final Stream<QuerySnapshot> _PrivateAmbulanceStream;

  @override
  void initState() {
    super.initState();
    _PrivateAmbulanceStream = FirebaseFirestore.instance
        .collection("AmbulanceList")
        .where("type", isEqualTo: "Private")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _PrivateAmbulanceStream,
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
            color: const Color.fromARGB(255, 189, 196, 204),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 105, 138, 168),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Private Ambulances',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 150,
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
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    GestureDetector(
                                      onTap: () {
                                        FlutterClipboard.copy(snapshot
                                            .data!.docs[index]["phoneNumber"]);
                                        CopiedSnackBar.showSnackBar(context,
                                            'Phone Number copied to Clipboard');
                                      },
                                      child: Text(
                                        snapshot.data!.docs[index]
                                            ['phoneNumber'],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      snapshot.data!.docs[index]['email'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['location'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
