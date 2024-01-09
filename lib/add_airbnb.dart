import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AddAirbnb extends StatefulWidget {
  const AddAirbnb({Key? key});

  @override
  State<AddAirbnb> createState() => _AddAirbnbState();
}

class _AddAirbnbState extends State<AddAirbnb> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPlace = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerPlace.dispose();
    _controllerPrice.dispose();
    super.dispose();
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.logout),
          )
        ],
        title: const Text('Add Airbnb'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink[200],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: _controllerName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Airbnb name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: _controllerPlace,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter location',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter place';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: _controllerPrice,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the price',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _loading
                    ? null
                    : () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    saveAirbnb(
                      update,
                      _controllerName.text.toString(),
                      _controllerPlace.text.toString(),
                      int.parse(_controllerPrice.text.toString()),
                    );
                  }
                },
                child: const Text('Add Airbnb to Database'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[200],
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: _loading,
                child: const CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> saveAirbnb(
    Function(String text) update,
    String name,
    String place,
    int price,
    ) async {
  try {
    final response = await http.post(
      Uri.parse('https://airbnbbyjoubaei.000webhostapp.com/saveAirbnb'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(
        <String, dynamic>{
          'name': name,
          'place': place,
          'price': price.toString(),
          // Additional parameters if needed
        },
      ),
    ).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      update(response.body);
    }
  } catch (e) {
    print("Error: $e");
    update("Error: $e");
  }
}
