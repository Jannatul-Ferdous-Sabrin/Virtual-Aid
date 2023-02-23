import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DoctorDetails.dart';

class SearchList extends StatefulWidget {
  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final FirebaseFirestore _ref = FirebaseFirestore.instance;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> _searchResult = [];
  bool _isLoading = false;

  Future<void> _searchDoctors(String searchQuery) async {
    setState(() {
      _isLoading = true;
    });

    if (searchQuery.isEmpty) {
      setState(() {
        _isLoading = false;
        _searchResult = [];
      });
      return;
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _ref
        .collection('DoctorList')
        .where('name', isEqualTo: searchQuery)
        //.where('name', isLessThanOrEqualTo: searchQuery)
        .get();

    setState(() {
      _isLoading = false;
      _searchResult = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      appBar: AppBar(
        title: const Text("Search for Doctors"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextFormField(
              onChanged: (value) => _searchDoctors(value),
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
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_searchResult.isEmpty)
            const Center(child: Text('No results found.'))
          else
            Expanded(
              child: ListView.builder(
                itemCount: _searchResult.length,
                itemBuilder: (context, index) {
                  final doctor = _searchResult[index].data();
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetails(
                            doctorDetails: _searchResult[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(doctor['name']),
                        subtitle: Text(doctor['specialist']),
                        trailing: Text(doctor['hospital']),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
