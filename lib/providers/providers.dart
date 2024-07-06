import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../services/quran_service.dart';

// State to hold selected language and type
final selectedLanguageProvider = StateProvider<String>((ref) => '');
final selectedTypeProvider = StateProvider<String>((ref) => '');

final quranEditionProvider = FutureProvider.family<List<dynamic>, String>(
    (ref, editionIdentifier) async {
  final response = await http
      .get(Uri.parse('http://api.alquran.cloud/v1/quran/$editionIdentifier'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data']['surahs'] as List;
    return data;
  } else {
    throw Exception('Failed to load Quran edition');
  }
});
// Provider for fetching all editions initially
final allEditionsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final response =
      await http.get(Uri.parse('http://api.alquran.cloud/v1/edition'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'];
    return List<Map<String, dynamic>>.from(
        data.map((item) => item as Map<String, dynamic>));
  } else {
    throw Exception('Failed to load editions');
  }
});

// Provider for fetching languages
final languagesProvider = FutureProvider<List<String>>((ref) async {
  final response =
      await http.get(Uri.parse('http://api.alquran.cloud/v1/edition/language'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'] as List;
    return data.map((lang) => lang as String).toList();
  } else {
    throw Exception('Failed to load languages');
  }
});

// Provider for fetching types
final typesProvider = FutureProvider<List<String>>((ref) async {
  final response =
      await http.get(Uri.parse('http://api.alquran.cloud/v1/edition/type'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'] as List;
    return data.map((type) => type as String).toList();
  } else {
    throw Exception('Failed to load types');
  }
});

// Provider for fetching filtered editions based on language and type
final filteredEditionsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, Map<String, String>>(
        (ref, params) async {
  final language = params['language'];
  final type = params['type'];

  final queryParameters = {
    if (language != null && language.isNotEmpty) 'language': language,
    if (type != null && type.isNotEmpty) 'type': type,
  };

  final uri = Uri.http('api.alquran.cloud', '/v1/edition', queryParameters);

  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data'];
    return List<Map<String, dynamic>>.from(
        data.map((item) => item as Map<String, dynamic>));
  } else {
    throw Exception('Failed to load filtered editions');
  }
});
final quranServiceProvider = Provider<QuranService>((ref) => QuranService());

final surahsProvider = FutureProvider<List<dynamic>>((ref) async {
  final quranService = ref.read(quranServiceProvider);
  return quranService.getSurahs();
});

final ayahsProvider =
    FutureProvider.family<List<dynamic>, int>((ref, surahNumber) async {
  final quranService = ref.read(quranServiceProvider);
  return quranService.getAyahs(surahNumber);
});

class JuzRequest {
  final int juzNumber;
  final String editionIdentifier;

  JuzRequest(this.juzNumber, this.editionIdentifier);
}

final juzProvider =
    FutureProvider.family<List<dynamic>, JuzRequest>((ref, request) async {
  final response = await http.get(Uri.parse(
      'http://api.alquran.cloud/v1/juz/${request.juzNumber}/${request.editionIdentifier}'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body)['data']['ayahs'] as List;
    return data;
  } else {
    throw Exception('Failed to load Juz');
  }
});
