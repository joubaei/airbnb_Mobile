import 'dart:ui';

import 'package:flutter/material.dart';
import 'add_airbnb.dart';
import 'view_airbnb.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
        centerTitle: true,
          backgroundColor: Colors.pink[200]
      ),
      body: Stack(
          fit: StackFit.expand,
          children: [
      // Background Image with Blur Effect
      Container(
      decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/homepic.jpg'), // Replace with your image asset
      fit: BoxFit.cover,
         ),
        ), child: BackdropFilter(
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
          ElevatedButton(
            child: Text('Add Airbnb'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddAirbnb();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.pink[200], // Change the color of the button
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: Text('view Airbnbs'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ViewAirbnb();
                  },
                ),
              );
            },style: ElevatedButton.styleFrom(
            primary: Colors.pink[200], // Change the color of the button
          ),
          ),
        ]),
      ),
    ],
    ),
    );
  }
}


