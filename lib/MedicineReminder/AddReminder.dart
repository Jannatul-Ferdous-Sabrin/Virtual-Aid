import 'package:flutter/material.dart';

class AddReminder extends StatefulWidget {
  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final _formKey = GlobalKey<FormState>();
  String _medicineName = '';
  int _amountPerTime = 0;

  final Map<String, bool> _selectedCheckboxes = {
    'Breakfast': false,
    'Lunch': false,
    'Dinner': false,
  };

  void _updateSelectedCheckboxes(String key, bool value) {
    setState(() {
      _selectedCheckboxes[key] = value;
    });
  }

  Map<String, TimeOfDay?> _selectedTimes = {
    'Breakfast': null,
    'Lunch': null,
    'Dinner': null,
  };

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Medicine name: $_medicineName');
      print('Amount per time: $_amountPerTime');
      print('Selected times: $_selectedTimes');
    }
  }

  void _showTimePicker(String key) async {
    final initialTime = _selectedTimes[key] ?? TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTimes = Map.from(_selectedTimes);
        _selectedTimes[key] = pickedTime;
        _selectedCheckboxes[key] = true;
      });
    } else if (_selectedTimes.containsKey(key)) {
      setState(() {
        _selectedTimes = Map.from(_selectedTimes);
        _selectedTimes.remove(key);
        _selectedCheckboxes[key] = false;
      });
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
              decoration: InputDecoration(labelText: 'Medicine Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the medicine name';
                }
                return null;
              },
              onChanged: (value) {
                _medicineName = value;
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
                _amountPerTime = int.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 16),
            const Text('Select times:'),
            CheckboxListTile(
              title: const Text('Breakfast'),
              value: _selectedCheckboxes['Breakfast'],
              onChanged: (value) {
                _updateSelectedCheckboxes('Breakfast', value!);
                if (value) {
                  _showTimePicker('Breakfast');
                } else {
                  setState(() {
                    _selectedTimes.remove('Breakfast');
                  });
                }
              },
            ),
            if (_selectedTimes.containsKey('Breakfast'))
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(
                    'Time: ${_selectedTimes['Breakfast']?.format(context) ?? ""}'),
                onTap: () {
                  _showTimePicker('Breakfast');
                },
              ),
            CheckboxListTile(
              title: const Text('Lunch'),
              value: _selectedCheckboxes['Lunch'],
              onChanged: (value) {
                _updateSelectedCheckboxes('Lunch', value!);
                if (value) {
                  _showTimePicker('Lunch');
                } else {
                  setState(() {
                    _selectedTimes.remove('Lunch');
                  });
                }
              },
            ),
            if (_selectedTimes.containsKey('Lunch'))
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(
                    'Time: ${_selectedTimes['Lunch']?.format(context) ?? ""}'),
                onTap: () {
                  _showTimePicker('Lunch');
                },
              ),
            CheckboxListTile(
              title: const Text('Dinner'),
              value: _selectedCheckboxes['Dinner'],
              onChanged: (value) {
                _updateSelectedCheckboxes('Dinner', value!);
                if (value) {
                  _showTimePicker('Dinner');
                } else {
                  setState(() {
                    _selectedTimes.remove('Dinner');
                  });
                }
              },
            ),
            if (_selectedTimes.containsKey('Dinner'))
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(
                    'Time: ${_selectedTimes['Dinner']?.format(context) ?? ""}'),
                onTap: () {
                  _showTimePicker('Dinner');
                },
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
