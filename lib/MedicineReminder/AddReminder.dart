// ignore_for_file: file_names, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddReminder extends StatefulWidget {
  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final _formKey = GlobalKey<FormState>();
  String? medicineName;
  int? amountPerTime;
  TimeOfDay? selectedTime;
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  //bool _isWeeklyRepeatOn = false;

  final List<bool> _isSelected = List.generate(7, (index) => false);

  Future<void> saveReminder() async {
    if (_formKey.currentState!.validate() && selectedTime != null) {
      CollectionReference reminderRef =
          FirebaseFirestore.instance.collection('MedicineReminderList');

      List<String> selectedDays = [];

      for (int i = 0; i < days.length; i++) {
        if (_isSelected[i]) {
          selectedDays.add(days[i]);
        }
      }

      await reminderRef.doc().set({
        'medName': medicineName,
        'amount': amountPerTime,
        'dateTime': selectedTime!.format(context),
        'days': selectedDays,
        'userEmail': FirebaseAuth.instance.currentUser!.email,
      });
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields and select time.'),
          backgroundColor: Colors.red.withOpacity(0.8),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 228, 216),
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.75),
        title: const Text(
          "Add Reminder",
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Medicine Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter the Medicine Name';
                }
                return null;
              },
              onChanged: (value) {
                medicineName = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount per Time'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the amount per time';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onChanged: (value) {
                amountPerTime = int.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 16),
            const Text('Select times:'),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                      icon: const Icon(Icons.access_time),
                      tooltip: 'Select Time',
                    ),
                    if (selectedTime != null)
                      Text(
                        selectedTime!.format(context),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 16),
            ToggleButtons(
              isSelected: _isSelected,
              onPressed: (int index) {
                setState(() {
                  _isSelected[index] = !_isSelected[index];
                });
              },
              children: days.map((day) => Text(day)).toList(),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     const Text('Repeat Weekly:'),
            //     IconButton(
            //       icon: _isWeeklyRepeatOn
            //           ? const Icon(Icons.check_box_rounded)
            //           : const Icon(Icons.square_outlined),
            //       onPressed: () {
            //         setState(() {
            //           _isWeeklyRepeatOn = !_isWeeklyRepeatOn;
            //         });
            //       },
            //     ),
            //   ],
            // ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {
                  saveReminder();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
