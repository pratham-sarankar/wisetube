import 'dart:convert';

import 'package:http/http.dart';

class SuggestionsService {
  static Future<List<String>> fetchSuggestions(String query) async {
    final response = await get(Uri.parse(
        "http://suggestqueries.google.com/complete/search?client=firefox&q=$query"));
    final body = jsonDecode(response.body);
    return (body[1] as List).whereType<String>().toList();
  }
}
