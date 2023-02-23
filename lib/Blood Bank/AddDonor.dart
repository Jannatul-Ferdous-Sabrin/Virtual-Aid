import 'package:flutter/material.dart';

class AddDonor extends StatefulWidget {
  @override
  State<AddDonor> createState() => _AddDonorState();
}

class _AddDonorState extends State<AddDonor> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerLocation = TextEditingController();

  String? name;
  String? phone;
  String? location;
  String? bloodgroupValue;
  int? age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 197, 193),
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(0.85),
        title: const Text("Add Donor"),
      ),
      body: ListView(
        children: [
          TextFormField(
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Name must not be Empty";
              }
            },
            controller: controllerName,
            decoration: const InputDecoration(
              label: Text("Name"),
            ),
            onChanged: (value) {
              name = value;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Age must not be Empty";
              }
            },
            controller: controllerAge,
            decoration: const InputDecoration(
              label: Text("Age"),
            ),
            onChanged: (value) {
              age = int.parse(value);
            },
          ),
          TextFormField(
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Location must not be Empty";
              }
            },
            controller: controllerLocation,
            decoration: const InputDecoration(
              label: Text("Location"),
            ),
            onChanged: (value) {
              location = value;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Phone must not be Empty";
              }
            },
            controller: controllerPhone,
            decoration: const InputDecoration(
              label: Text("Phone"),
            ),
            onChanged: (value) {
              phone = value;
            },
          ),
          DropdownButton(
            hint: const Text("Blood Group"),
            items: bloodGroup.map<DropdownMenuItem<String>>(
              (e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              },
            ).toList(),
            onChanged: (String? value) {
              setState(() {
                bloodgroupValue = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> bloodGroup = [
  'A+',
  'A-',
  'AB+',
  'AB-',
  'B+',
  'B-',
  'O+',
  'O-',
];
