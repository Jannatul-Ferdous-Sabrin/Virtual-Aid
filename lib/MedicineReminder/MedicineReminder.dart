import 'package:flutter/material.dart';

import 'AddReminder.dart';

class MedicineReminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 228, 216),
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.75),
        title: const Text(
          "Medicine Reminder",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return AddReminder();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Material(),
    );
  }
}
