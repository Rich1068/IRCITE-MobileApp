import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carepathmobile/InfantDetails/InfantDetailsPage.dart';

void main() {
  runApp(SearchInputInfant());
}

class SearchInputInfant extends StatelessWidget {
  const SearchInputInfant({Key? key}) : super(key: key);

  Future<void> searchInfant(BuildContext context) async {
    // Load static data from JSON file
    final jsonString = await DefaultAssetBundle.of(context).loadString('assets/static_data.json');
    final data = json.decode(jsonString);

    // Navigate to InfantDetailsPage with the loaded data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InfantDetailsPage(data: data),
      ),
    );
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
                      "Please Input the necessary information to view the infant's vaccination details.",
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    buildTextField('Patient Number', TextEditingController()),
                    const SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => searchInfant(context),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF871818),
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