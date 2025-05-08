import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';

class DashboardScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFfbfbfb), // Hintergrundfarbe der App
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Linke Spalte: Suchfeld + Kartenbild + Buttons
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFD6D2F5), // Violett für das linke Panel
                  borderRadius: BorderRadius.circular(16),
                ),
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
                      Text(
                        cardProvider.errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    
                    // Kartenbild + Name
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
                    
                    // Platz für die Buttons ganz unten
                    Spacer(), // Dieser Spacer sorgt dafür, dass die Buttons immer am unteren Rand bleiben.

                    // Start und Stop Scan Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Start Scan Button
                        ElevatedButton(
                          onPressed: () {
                            // Funktionalität für "Start Scan"
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 186, 137, 231), // Farbe für Start Scan Button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Anpassbarer BorderRadius
                            ),
                          minimumSize: Size(150, 60),
                          ),
                          child: Text(
                            'Start Scan', 
                            style: TextStyle(
                              fontSize: 20, // Größere Textgröße
                              color: Colors.white, // Textfarbe weiß
                              fontWeight: FontWeight.bold, // Fettdruck
                            ),
                          ),
                          
                        ),
                        // Stop Scan Button
                        ElevatedButton(
                          onPressed: () {
                            // Funktionalität für "Stop Scan"
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(237, 222, 227, 231), // Farbe für Stop Scan Button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Anpassbarer BorderRadius
                            ),
                          minimumSize: Size(150, 60),
                          ),
                          child: Text(
                            'Stop Scan',
                            style: TextStyle(
                              fontSize: 20, // Größere Textgröße
                              color: const Color.fromARGB(255, 0, 0, 0), // Textfarbe weiß
                              fontWeight: FontWeight.bold, // Fettdruck
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Abstand nach den Buttons
                  ],
                ),
              ),
            ),

            const SizedBox(width: 20), // Abstand

            // 🔵 Rechte Spalte: Noch leer
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFEDE7F6), // Sanftes Violett für den leeren Bereich
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
