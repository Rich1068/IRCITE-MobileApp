import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carepathmobile/InfantDetails/InfantDetailsPage.dart';

void main() {
  runApp(const SearchInputInfant());
}

class SearchInputInfant extends StatefulWidget {
  const SearchInputInfant({Key? key}) : super(key: key);

  @override
  _SearchInputInfantState createState() => _SearchInputInfantState();
}

class _SearchInputInfantState extends State<SearchInputInfant> {
  final TextEditingController trackingNumberController =
      TextEditingController();

  @override
  void dispose() {
    trackingNumberController.dispose();
    super.dispose();
  }

  Future<void> searchInfant(BuildContext context, String patientNumber) async {
    // Load mock data from JSON file
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/mock_data.json');
    final data = json.decode(jsonString);

    // Check if the patientNumber exists in the data
    final infantData = data['infant'];

    if (infantData['tracking_number'] == patientNumber) {
      // Navigate to InfantDetailsPage with the found data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfantDetailsPage(data: data),
        ),
      );
    } else {
      // Show error dialog if infant data is not found
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:const Text(
                'Patient Number Not Found'),
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
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF016A52);
    return MaterialApp(
      title: 'Search Input Infant',
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.of(context).pop();
          }),
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
          child: SingleChildScrollView(
            child: Padding(
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
                  buildTextField('Patient Number', trackingNumberController),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        final patientNumber = trackingNumberController.text;
                        searchInfant(context, patientNumber);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        backgroundColor: const Color(0xFF016A52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Search Infant Details',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
