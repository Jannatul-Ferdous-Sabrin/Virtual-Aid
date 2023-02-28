// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DoctorDetails.dart';

class SearchList extends StatefulWidget {
  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        title: const Text("Search for Doctors"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Search for Doctors...",
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('DoctorList')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final searchResults = snapshot.data!.docs.where((doc) {
                  final name = doc.get('name').toString().toLowerCase();
                  final query = _searchController.text.toLowerCase();
                  return name.contains(query);
                }).toList();

                if (searchResults.isEmpty) {
                  return const Center(child: Text('No results found.'));
                }

                return ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final doctorDetails = searchResults[index];
                    final name = doctorDetails.get('name');
                    final specialist = doctorDetails.get('specialist');
                    final hospital = doctorDetails.get('hospital');

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(name),
                        subtitle: Text(specialist),
                        trailing: Text(hospital),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DoctorDetails(doctorDetails: doctorDetails),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
