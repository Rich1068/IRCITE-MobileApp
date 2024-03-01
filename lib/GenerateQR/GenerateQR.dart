import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GenerateQR extends StatefulWidget {
  final String fullName;
  final String gender;
  final String birthday;
  final String barangayId;
  final String weight;
  final String length;
  final String fathersName;
  final String mothersName;
  final String contactNumber;

  const GenerateQR({super.key, 
    required this.fullName,
    required this.gender,
    required this.birthday,
    required this.barangayId,
    required this.weight,
    required this.length,
    required this.fathersName,
    required this.mothersName,
    required this.contactNumber
  });

  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  _launchURL() async {  
    const url = 'https://facebook.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final qrData = '''
      Full Name: ${widget.fullName}
      Gender: ${widget.gender}
      Birthday: ${widget.birthday}
      Barangay ID: ${widget.barangayId}
      Weight: ${widget.weight}
      Length: ${widget.length}
      Father's Name: ${widget.fathersName}
      Mother's Name: ${widget.mothersName}
      Contact Number: ${widget.contactNumber}
    ''';

    return MaterialApp(
      title: 'Generate QR',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Generate QR'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _launchURL,
                child: const Text('Open Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
