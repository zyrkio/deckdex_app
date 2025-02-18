import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';

class DashboardScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Linke Spalte: Suchfeld + Kartenbild
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Suchfeld
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Kartennamen eingeben',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        cardProvider.searchCard(_controller.text);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Ladeindikator oder Fehleranzeige
                if (cardProvider.isLoading) CircularProgressIndicator(),
                if (cardProvider.errorMessage != null)
                  Text(cardProvider.errorMessage!, style: TextStyle(color: Colors.red)),

                // Kartenbild
                if (cardProvider.cardData != null)
                  Column(
                    children: [
                      Image.network(
                        cardProvider.cardData!['image_uris']?['normal'] ?? '',
                        width: 200,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 10),
                      Text(
                        cardProvider.cardData!['name'] ?? 'Unbekannt',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          SizedBox(width: 20), // Abstand zwischen den Spalten

          // 🔵 Rechte Spalte: Karteninformationen
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (cardProvider.cardData != null) ...[
                  // 📛 Kartenname
                  Text(
                    "Kartenname: ${cardProvider.cardData!['name'] ?? 'Unbekannt'}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  // 💰 Preis-Infos
                  Text(
                    "Preis: ${cardProvider.cardData!['prices']?['usd'] ?? 'Nicht verfügbar'} USD",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green),
                  ),
                  SizedBox(height: 10),

                  // 🔵 Kartentyp
                  Text(
                    "Typ: ${cardProvider.cardData!['type_line'] ?? 'Nicht verfügbar'}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),

                  // ⚡ Mana-Kosten
                  Text(
                    "Mana-Kosten: ${cardProvider.cardData!['mana_cost'] ?? 'Nicht verfügbar'}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),

                  // 🏆 Legalität in Formaten
                  Text(
                    "Legal in Commander: ${cardProvider.cardData!['legalities']?['commander'] ?? 'Nicht verfügbar'}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Legal in Modern: ${cardProvider.cardData!['legalities']?['modern'] ?? 'Nicht verfügbar'}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),

                  // 🏅 Rarity der Karte
                  Text(
                    "Seltenheit: ${cardProvider.cardData!['rarity'] ?? 'Nicht verfügbar'}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),

                  // 🌈 Farben der Karte
                  Text(
                    "Farben: ${cardProvider.cardData!['colors']?.join(', ') ?? 'Nicht verfügbar'}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),

                  // 🖼 Illustrator der Karte
                  Text(
                    "Illustrator: ${cardProvider.cardData!['artist'] ?? 'Nicht verfügbar'}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),

                  // 📦 Set-Informationen
                  Text(
                    "Set-Name: ${cardProvider.cardData!['set_name'] ?? 'Nicht verfügbar'}",
                    style: TextStyle(fontSize: 16),
                  ),

                  // 🔁 Andere Drucke der Karte
                  if (cardProvider.cardData!['prints_search_uri'] != null)
                    TextButton(
                      onPressed: () {
                        // Funktion zum Anzeigen anderer Drucke (zukünftige Erweiterung)
                      },
                      child: Text(
                        "Andere Drucke anzeigen",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
