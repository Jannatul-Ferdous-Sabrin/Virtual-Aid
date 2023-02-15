import 'package:flutter/material.dart';

class DoctorDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFD9E4EE),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/PKC-Pics_0.jpg'),
                  fit: BoxFit.fill,
                ),
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Dr. Proshanto Kumar',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Surgeon'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
