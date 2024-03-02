import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';

void main() {
  runApp(const EnterChildDetails());
}

class EnterChildDetails extends StatelessWidget {
  const EnterChildDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Enter Child Details',
      home: ChildDetailsForm(),
    );
  }
}

class ChildDetailsForm extends StatefulWidget {
  const ChildDetailsForm({super.key});

  @override
  _ChildDetailsFormState createState() => _ChildDetailsFormState();
}

class _ChildDetailsFormState extends State<ChildDetailsForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  String selectedGender = 'Male'; // Default gender

  DateTime? selectedDate;
  Uint8List? qrImageData;

  void generateAndShowQR() async {
  if (nameController.text.isEmpty ||
      selectedDate == null ||
      selectedGender.isEmpty ||
      weightController.text.isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Missing Required Fields'),
          content: const Text('All fields marked with * are required.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    // Ensure that non-required fields are not null but empty
    final Map<String, String> dataMap = {
      '1': nameController.text,
      '2': "${selectedDate!.toLocal()}".split(' ')[0],
      '3': selectedGender == 'Female' ? 'f' : 'm',  
      '4': weightController.text,
      '5': lengthController.text,
      '6': fatherNameController.text,
      '7': motherNameController.text,
      '8': contactNumberController.text,
    };

    String encodedData = '';
    dataMap.forEach((key, value) {
      encodedData += '$key=$value&';
    });

    // If the length is less than 80 characters, add the extra data
    // If the length is less than 80 characters, add the extra data
    if (encodedData.length < 78) {
      // Calculate the number of '1's needed
      int numberOfOnes = 78 - encodedData.length;

      // Use the String.fromCharCodes constructor to create a string with the specified number of '1's
      String onesString = String.fromCharCodes(List<int>.generate(numberOfOnes, (index) => '1'.codeUnitAt(0)));

      // Append the generated string to encodedData
      encodedData += '&9=$onesString';
    }

    final ByteData? byteData = await generateQrImage(encodedData);

    setState(() {
      qrImageData = byteData?.buffer.asUint8List();
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Generated QR Code'),
          content: Container(
            child: qrImageData != null ? Image.memory(qrImageData!) : const SizedBox.shrink(),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}




  Future<ByteData?> generateQrImage(String data) async {
    final QrPainter painter = QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: false,
    );

    try {
      final ByteData? byteData = await painter.toImageData(200.0);
      return byteData;
    } catch (e) {
      print('Error generating QR code: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () {
              print('pressed');
              Navigator.of(context).pop(); 
              }
          ),
        title: const Text(
          'Enter Child Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name*',
                  labelStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(),
                  suffix: Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
                items: ['Male', 'Female'].map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Gender*',
                  labelStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(),
                  suffix: Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  final DateTime now = DateTime.now();
                  showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(now.year - 1), // Allowing dates from one year ago
                    lastDate: now,
                    selectableDayPredicate: (DateTime day) {
                      // Disable future dates (including today)
                      return day.isBefore(now);
                    },
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        selectedDate = value;
                      });
                    }
                  });
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Birth Date*',
                      labelStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(),
                      suffix: Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    controller: TextEditingController(
                      text: selectedDate != null ? "${selectedDate!.toLocal()}".split(' ')[0] : '',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)*',
                  labelStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: lengthController,
                decoration: const InputDecoration(
                  labelText: 'Length (cm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: fatherNameController,
                decoration: const InputDecoration(
                  labelText: 'Father\'s Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: motherNameController,
                decoration: const InputDecoration(
                  labelText: 'Mother\'s Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: contactNumberController,
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                maxLength: 11,
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        selectedDate == null ||
                        selectedGender.isEmpty ||
                        weightController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Missing Required Fields'),
                            content: const Text('All fields marked with * are required.'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      generateAndShowQR();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF871818),
                  ),
                  child: const Text('Submit & Generate QR'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}