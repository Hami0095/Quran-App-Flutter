// screens/surah_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/constants/my_colors.dart';
import '../providers/providers.dart';

class SurahList extends ConsumerWidget {
  const SurahList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedEdition =
    //     ref.watch(selectedEditionProvider) ?? 'quran-uthmani';
    final surahsAsyncValue = ref.watch(surahsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quran App'),
      ),
      body: surahsAsyncValue.when(
        data: (surahs) {
          return ListView.builder(
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              final surah = surahs[index];
              return ListTile(
                title: Text(surah['englishName']),
                subtitle: Text(surah['name']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AyahList(surahNumber: surah['number']),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class AyahList extends ConsumerWidget {
  final int surahNumber;

  const AyahList({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ayahsAsyncValue = ref.watch(ayahsProvider(surahNumber));

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Ayahs',
          style: GoogleFonts.montserrat().copyWith(color: Colors.white),
        ),
        backgroundColor: customDarkGreen,
      ),
      body: ayahsAsyncValue.when(
        data: (ayahs) {
          return ListView.builder(
            itemCount: ayahs.length,
            itemBuilder: (context, index) {
              final ayah = ayahs[index];
              return ListTile(
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(ayah['text']),
                ),
                // subtitle: Text('Ayah ${ayah['numberInSurah']}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
