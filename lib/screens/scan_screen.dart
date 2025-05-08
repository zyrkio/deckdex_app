import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          children: [
            // Linkes Panel
          
            Expanded(
              flex:2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFD6D2F5), // Violett wie im Bild
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Rechtes Panel
            Expanded(
              flex:1,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFD6D2F5), // Gleiche Farbe wie linkes Panel
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
