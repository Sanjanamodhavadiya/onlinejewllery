import 'package:flutter/material.dart';
import 'package:onlinejewllery/EditProfilePage.dart';
import 'package:onlinejewllery/loginPage.dart'; // Import the LoginPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Snjana Mdhavadiya';
  String email = 'sanjumodhavadiya9@gmail.com';
  String phone = '+91 63558 62202';
  String address = 'GURUKUL GILS HOSTEL , Panchayt chowk , Rajkot , 360005';

  void _editProfile() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          name: name,
          email: email,
          phone: phone,
          address: address,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        name = result['name'];
        email = result['email'];
        phone = result['phone'];
        address = result['address'];
      });
    }
  }

  void _logOut() {
    // Navigate to the LoginPage when the Log Out button is clicked
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontSize: 30)),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage('assets/WhatsApp Image 2024-09-04 at 8.56.43 AM.jpeg'),
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
              'Name: $name',
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Email: $email',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Phone: $phone',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Address: $address',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _editProfile,
              style: ElevatedButton.styleFrom(),
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _logOut, // Calls the _logOut method to navigate to LoginPage
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Optional: Set the button color
              ),
              child: const Text('Log Out',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}