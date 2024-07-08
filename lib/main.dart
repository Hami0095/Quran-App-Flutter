import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'constants/my_colors.dart'; // Import your custom colors here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Your App Title',
        theme: ThemeData(
          primaryColor: customDarkGreen, // Set your primary color
          scaffoldBackgroundColor: Colors.white, // Set your background color
          dialogTheme: const DialogTheme(
            backgroundColor: Colors.white, // Dialog background color
          ),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: customDarkGreen, // Circular progress indicator color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: customDarkGreen, // Text color for TextButton
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
