import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final EncryptedSharedPreferences _encryptedData = EncryptedSharedPreferences();

  Future<void> signUp() async {
    final Uri url = Uri.parse('https://airbnbbyjoubaei.000webhostapp.com/signupFinalProj.php');
    final response = await http.post(url, body: {
      'name': _nameController.text.toString(),
      'email': _emailController.text.toString(),
      'password': _passwordController.text.toString(),
    });

    if (response.statusCode == 200) {
      // Registration successful, you might want to handle it accordingly
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
    } else {
      // Registration failed, handle the error or show an error message
      print('Failed to Sign Up: ${response.reasonPhrase}');
    }
  }
  void login(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
          backgroundColor: Colors.pink[200]
      ),
      body: Stack(
        children: [
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
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Name',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Email',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: login,
                  child: const Text('Already have an account? Log in'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[200], // Change the color of the button
                ),
          ),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: signUp, child: const Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[200], // Change the color of the button
                  ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
