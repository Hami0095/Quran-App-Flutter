import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/constants/my_colors.dart';
import 'package:quran_app/screens/settings_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: customDarkGreen,
      ),
      home: const SettingsScreen(),
      // routes: {
      //   '/': (context) => const SettingsScreen(),
      //   '/settings': (context) => const SettingsScreen(),
      //   '/surah-list': (context) => const SurahList(),
      // },
    );
  }
}
