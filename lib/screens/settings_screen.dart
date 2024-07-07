import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/constants/my_colors.dart';
import 'package:quran_app/providers/providers.dart';
import 'editions_list.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<String>> languages = ref.watch(languagesProvider);
    final AsyncValue<List<String>> types = ref.watch(typesProvider);
    final String selectedLanguage = ref.watch(selectedLanguageProvider);
    final String selectedType = ref.watch(selectedTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: customDarkGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            languages.when(
              data: (data) {
                return DropdownButton<String>(
                  hint: const Text('Select Language'),
                  value: selectedLanguage.isEmpty ? null : selectedLanguage,
                  onChanged: (value) {
                    ref.read(selectedLanguageProvider.notifier).state = value!;
                  },
                  items: data.map((lang) {
                    return DropdownMenuItem<String>(
                      value: lang,
                      child: Text(lang),
                    );
                  }).toList(),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
            const SizedBox(height: 20),
            types.when(
              data: (data) {
                return DropdownButton<String>(
                  hint: const Text('Select Type'),
                  value: selectedType.isEmpty ? null : selectedType,
                  onChanged: (value) {
                    ref.read(selectedTypeProvider.notifier).state = value!;
                  },
                  items: data.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final params = {
                  'language': selectedLanguage,
                  'type': selectedType,
                };
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditionsList(params: params),
                  ),
                );
              },
              child: const Text('Continue to Editions List'),
            ),
          ],
        ),
      ),
    );
  }
}
