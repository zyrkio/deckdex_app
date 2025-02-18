import 'package:flutter/material.dart';
import '../services/scryfall_api.dart';

class CardProvider extends ChangeNotifier {
  final ScryfallApiService _apiService = ScryfallApiService();
  Map<String, dynamic>? cardData;
  bool isLoading = false;
  String? errorMessage;

  Future<void> searchCard(String cardName) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      cardData = await _apiService.fetchCard(cardName);
    } catch (e) {
      errorMessage = 'Karte nicht gefunden!';
    }

    isLoading = false;
    notifyListeners();
  }
}
