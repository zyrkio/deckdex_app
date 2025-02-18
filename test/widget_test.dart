import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deckdex_app/main.dart';

void main() {
  testWidgets('MyApp loads Dashboard correctly', (WidgetTester tester) async {
    // Baue die App und starte das erste Frame
    await tester.pumpWidget(const MyApp(title: "MTG App"));

    // Überprüfe, ob das Dashboard geladen wurde
    expect(find.text('Willkommen in Dashboard!'), findsOneWidget);
    expect(find.text('Willkommen in Karten scannen!'), findsNothing);
  });
}
