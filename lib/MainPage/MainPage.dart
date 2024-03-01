import 'package:carepathmobile/EnterChildDetails/EnterChildDetails.dart';
import 'package:carepathmobile/SearchInputInfant/SearchInputInfant.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, Key? keyy});

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
        children: [
          Image.asset(
            'assets/BGHOME.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/1.png', width: 200, height: 200),
                    Image.asset('assets/AC_LOGO.png', width: 110, height: 110),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Check for internet connection before navigating
                    var connectivityResult = await Connectivity().checkConnectivity();
                    if (connectivityResult == ConnectivityResult.none) {
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
                    } else {
                      // Navigate to the SearchInputInfant page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SearchInputInfant()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF871818), // Text color
                  ),
                  child: const Text('Search Child Vaccination Details'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EnterChildDetails()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color(0xFF871818), // Text color
                  ),
                  child: const Text('Input Child Details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
