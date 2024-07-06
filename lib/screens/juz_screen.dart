// screens/juz_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class JuzScreen extends ConsumerWidget {
  final String editionIdentifier;
  final int juzNumber;

  const JuzScreen({
    Key? key,
    required this.editionIdentifier,
    required this.juzNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final juz =
        ref.watch(juzProvider(JuzRequest(juzNumber, editionIdentifier)));

    return Scaffold(
      appBar: AppBar(
        title: Text('Juz $juzNumber: $editionIdentifier'),
        backgroundColor: Colors.green,
      ),
      body: juz.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final ayah = data[index];
              return ListTile(
                title: Text(
                    '${ayah['surah']['englishName']} - Ayah ${ayah['numberInSurah']}'),
                subtitle: Text(ayah['text']),
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
