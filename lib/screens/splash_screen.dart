import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quran_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay navigation to home screen for 2 seconds
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomeScreen()), // Replace with your home screen route
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Adjust background color if needed
      body: Center(
        child: Image.asset(
            'assets/splash_screen.jpg'), // Adjust path and filename accordingly
      ),
    );
  }
}
