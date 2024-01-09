import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

final List<String> _airbnb = [];
const String _baseURL = 'airbnbbyjoubaei.000webhostapp.com';

class ViewAirbnb extends StatefulWidget {
  const ViewAirbnb({super.key});

  @override
  State<ViewAirbnb> createState() => _ViewAirbnbState();
}

class _ViewAirbnbState extends State<ViewAirbnb> {
  bool _load = false;

  void update(bool success) {
    setState(() {
      _load = true;
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }


  @override
  void initState() {
    updateCars(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Available Airbnbs in Database'),
          centerTitle: true,
            backgroundColor: Colors.pink[200]

        ),body: Stack(
        children: [
    Container(
    decoration: BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/background_image.jpg'), // Replace with your image path
      fit: BoxFit.cover,
    ),
    ),
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    child: Container(
    color: Colors.black.withOpacity(0.3), // Adjust opacity as needed
    ),
    ),
    ),
         _load ? const ListCars() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator()),
        ),

    ],
    ),
    );
  }
}

class ListCars extends StatelessWidget {
  const ListCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _airbnb.length,
        itemBuilder: (context, index){ List<String> details = _airbnb[index].split(':');

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            elevation: 4.0,
            child: ListTile(
              title: Text(
                details[0], // Name
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details[1], // Place
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 5),
                    Text(
                      details[2], // Price
                      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5),
                    Text(
                      details[3], // Price
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        },
    );
  }
}

void updateCars(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getAirbnb.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));

    _airbnb.clear(); // Clear old data

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = convert.jsonDecode(response.body);

      for (var row in jsonResponse) {
        _airbnb.add(' name: ${row['name']} : place: ${row['place']} : price: ${row['price']}');

      }

      update(true);
    } else {
      print('HTTP Error: ${response.statusCode}'); // Print HTTP error status code
      update(false); // Inform that an error occurred
    }
  } catch (e) {
    print('Error occurred: $e'); // Print error message to the console
    update(false); // Inform that an error occurred
  }
}

