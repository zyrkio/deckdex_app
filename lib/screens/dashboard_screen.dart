import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16), // Abstand um das gesamte Layout
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Elemente oben ausrichten
          children: [
            // Linke große Box
            Expanded(
              flex: 2, // Größer als die rechte Spalte
              child: Container(
                
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(width: 16), // Abstand zwischen den Spalten

            // Rechte Spalte mit zwei grünen Boxen
            Expanded(
              flex: 1, // Kleiner als die linke Box
              child: Column(
                children: [
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  SizedBox(height: 16), // Abstand zwischen den Boxen

                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
