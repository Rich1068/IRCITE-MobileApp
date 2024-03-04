import 'package:carepathmobile/EnterChildDetails/EnterChildDetails.dart';
import 'package:carepathmobile/SearchInputInfant/SearchInputInfant.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        // Show a pop-up when there is no internet
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('No Internet Connection'),
              content: const Text('Please check your internet connection.'),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg1.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 250, // Adjust the top position as needed
            left: 10,
            right: 0,
            child: Image.asset('assets/logo1.png', width: 380, height: 220),
          ),
          Positioned(
            top: 350, // Adjust the top position as needed
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 150),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20), // Add padding on both sides
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Securing Their Future: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: 'Infant Immunization ',
                            style: TextStyle(
                              color: Color(0xFF016A52),
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: 'Made Simple',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 260, // Set width as needed
                        child: ElevatedButton(
                          onPressed: () async {
                            // Check for internet connection before navigating
                            var connectivityResult =
                                await Connectivity().checkConnectivity();
                            if (connectivityResult == ConnectivityResult.none) {
                              // Show a pop-up when there is no internet
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('No Internet Connection'),
                                    content: const Text(
                                        'Please check your internet connection.'),
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
                            } else {
                              // Navigate to the SearchInputInfant page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchInputInfant()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, // Text Color
                            backgroundColor:
                                const Color(0xFF016A52), // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Search Child Vaccination Details',textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 260, // Set width as needed
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EnterChildDetails()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color(0xFF016A52), // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Input Child Details',textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
