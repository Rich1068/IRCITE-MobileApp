import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carepathmobile/InfantDetails/InfantDetailsPage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SearchInputInfant());
}

class SearchInputInfant extends StatefulWidget {
  const SearchInputInfant({super.key});

  @override
  _SearchInputInfantState createState() => _SearchInputInfantState();
}

class _SearchInputInfantState extends State<SearchInputInfant> {
  final TextEditingController trackingNumberController = TextEditingController();

  @override
  void dispose() {
    trackingNumberController.dispose();
    super.dispose();
  }

  Future<void> searchInfant() async {
    final trackingNumber = trackingNumberController.text;
    final apiUrl = 'https://carepath.cloud/api/search-infant/$trackingNumber';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfantDetailsPage(data: data['data']),
          ),
        );
      } else {
        // Handle error cases
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Patient Number Not Found'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error $e');
      // Handle other exceptions as needed
    }
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF871818);
    return MaterialApp(
      title: 'Search Input Infant',
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              }
          ),
          title: const Text(
            'Search Input Infant',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: backgroundColor,
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 8.0),
                    const Text(
                      'Please Input the necessary information to view the infant’s vaccination details.',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    buildTextField('Patient Number', trackingNumberController),
                    const SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: searchInfant,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: const Color(0xFF871818),
                        ),
                        child: const Text('Search Infant Details'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
