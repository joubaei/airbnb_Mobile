import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _HomeState();
}

class _HomeState extends State<Login> {
  final TextEditingController _namecontroller= TextEditingController();
  final TextEditingController _emailcontroller= TextEditingController();
  final TextEditingController _passwordcontroller= TextEditingController();
  final EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();

  Future<void> checklogin() async {
    final Uri url = Uri.parse('https://airbnbbyjoubaei.000webhostapp.com/loginFinalProj.php'); // Replace with your registration endpoint
    final response = await http.post(url, body: {
      'name': _namecontroller.text.toString(),
      'email': _emailcontroller.text.toString(),
      'password': _passwordcontroller.text.toString(),
    });

    if (response.statusCode == 200) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Home()));
    } else {
      print('Failed to Log In: ${response.reasonPhrase}');
      // Handle the error case, show an error message or take appropriate action
    }
  }


  void update(bool success) {
    if (success) { // open the Add Category page if successful
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Home()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('failed to log in')));
    }
  }

  void checkSavedData() async {
    _encryptedData.getString('password').then((String password) {
      if (password.isNotEmpty) {
        Navigator.of(context)
            .push(MaterialPageRoute(
            builder: (context) => const Home()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // call the below function to check if key exists
    checkSavedData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
          backgroundColor: Colors.pink[200]
      ),
      body: Stack(
          children: [
      // Background Image with Blur Effect
      Container(
      decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/airbnblogin.jpg'),
      fit: BoxFit.cover,
    ),
    ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
           color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
          ),
           ),
         ),Center(
          child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const SizedBox(height: 10),
            SizedBox(
                width: 200,
                child: TextField(
                  // replace typed text with * for passwords

                  enableSuggestions: false, // disable suggestions for password
                  autocorrect: false, // disable auto correct for password
                  controller: _namecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter Name'),
                )),
            const SizedBox(height: 10),
            SizedBox(
                width: 200,
                child: TextField(
                  // replace typed text with * for passwords

                  enableSuggestions: false, // disable suggestions for password
                  autocorrect: false, // disable auto correct for password
                  controller: _emailcontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter Email'),
                )),
            const SizedBox(height: 10),
            SizedBox(
                width: 200,
                child: TextField(
                  // replace typed text with * for passwords
                  obscureText: true,
                  enableSuggestions: false, // disable suggestions for password
                  autocorrect: false, // disable auto correct for password
                  controller: _passwordcontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter Password'),
                )),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: checklogin, child: const Text('Log in'),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink[200], // Change the color of the button
              ),)
          ])),
  ],
    ),
    );
  }
}
