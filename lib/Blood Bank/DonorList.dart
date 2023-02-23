import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AddDonor.dart';

class DonorList extends StatefulWidget {
  @override
  State<DonorList> createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
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
                                snapshot.data!.docs[index]['age'].toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                snapshot.data!.docs[index]['PhoneNumber'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Text(
                              snapshot.data!.docs[index]['BloodGroup'],
                              style: const TextStyle(
                                fontSize: 24,
                              ),
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
        backgroundColor: Colors.red,
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
