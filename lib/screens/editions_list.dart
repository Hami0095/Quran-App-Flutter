// screens/editions_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import 'juz_screen.dart';

class EditionsList extends ConsumerWidget {
  final Map<String, String>? params;

  const EditionsList({super.key, this.params});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the params to fetch editions if provided, otherwise fetch all editions
    final editions = ref.watch(allEditionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editions List'),
        backgroundColor: Colors.green,
      ),
      body: editions.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final edition = data[index];
              return ListTile(
                title: Text(edition['englishName']),
                subtitle: Text(edition['name']),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Select Juz'),
                      content: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Enter Juz Number (1-30)',
                        ),
                        onSubmitted: (value) {
                          final juzNumber = int.tryParse(value);
                          if (juzNumber != null &&
                              juzNumber > 0 &&
                              juzNumber <= 30) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JuzScreen(
                                  editionIdentifier: edition['identifier'],
                                  juzNumber: juzNumber,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please enter a valid Juz number (1-30).')),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
