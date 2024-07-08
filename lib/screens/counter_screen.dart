import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/constants/my_colors.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: _incrementCounter,
              child: Container(
                width: 300, // Adjust button size as needed
                height: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green, // Adjust button color as needed
                ),
                child: Center(
                  child: Text(
                    '$_counter',
                    style: GoogleFonts.montserrat(
                      fontSize: 48,
                      color: Colors.white, // Adjust text color as needed
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetCounter,
              child: Text(
                'Reset',
                style: GoogleFonts.montserrat(
                  color: Colors.black, // Adjust text color as needed
                ).copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
