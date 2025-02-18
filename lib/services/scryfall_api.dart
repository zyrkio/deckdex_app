import 'dart:convert';
import 'package:http/http.dart' as http;

class ScryfallApiService {
  static const String baseUrl = 'https://api.scryfall.com/cards/named';

  Future<Map<String, dynamic>> fetchCard(String cardName) async {
    final Uri url = Uri.parse('$baseUrl?fuzzy=$cardName');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fehler beim Laden der Karte');
    }
  }
}
