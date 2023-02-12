import 'package:flutter/material.dart';

class AmbulanceHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambulance'),
      ),
      body: const Center(
        child: Text(
          'Ambulance',
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
