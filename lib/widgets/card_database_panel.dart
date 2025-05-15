import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/card_database.dart';
import '../model/card_entry.dart';
import '../providers/card_provider.dart';

class CardDatabasePanel extends StatefulWidget {
  @override
  _CardDatabasePanelState createState() => _CardDatabasePanelState();
}

class _CardDatabasePanelState extends State<CardDatabasePanel> {
  List<CardEntry> cards = [];

  @override
  void initState() {
    super.initState();
    _loadCardsFromDB();
  }

  Future<void> _loadCardsFromDB() async {
    final storedCards = await CardDatabase.instance.readAllCards();
    setState(() {
      cards = storedCards;
    });
  }

  Future<void> _addCard(CardEntry card) async {
    final stored = await CardDatabase.instance.create(card);
    setState(() {
      cards.add(stored);
    });
  }

  void _deleteSelected() async {
    final toDelete = cards.where((c) => c.selected && c.id != null).toList();
    for (var card in toDelete) {
      await CardDatabase.instance.delete(card.id!);
    }
    setState(() {
      cards.removeWhere((c) => c.selected);
    });
  }

  void _selectAll() {
    setState(() {
      for (var card in cards) {
        card.selected = true;
      }
    });
  }

  void _showAddDialog() {
    String searchName = '';
    final cardProvider = Provider.of<CardProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('Magic-Karte suchen und hinzufügen'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Kartennamen eingeben'),
                    onChanged: (value) => searchName = value,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await cardProvider.searchCard(searchName);
                      setState(() {});
                    },
                    child: Text('Suchen'),
                  ),
                  const SizedBox(height: 10),
                  if (cardProvider.isLoading) CircularProgressIndicator(),
                  if (cardProvider.errorMessage != null)
                    Text(cardProvider.errorMessage!, style: TextStyle(color: Colors.red)),
                  if (cardProvider.cardData != null)
                    Column(
                      children: [
                        Image.network(
                          cardProvider.cardData!['image_uris']?['normal'] ?? '',
                          width: 150,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 10),
                        Text(cardProvider.cardData!['name'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(cardProvider.cardData!['type_line'] ?? ''),
                        Text(cardProvider.cardData!['set_name'] ?? ''),
                        Text(cardProvider.cardData!['mana_cost'] ?? ''),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            final card = CardEntry(
                              name: cardProvider.cardData!['name'] ?? 'Unbekannt',
                              subject: cardProvider.cardData!['type_line'] ?? '',
                              date: DateTime.now().toIso8601String(),
                              set: cardProvider.cardData!['set_name'] ?? 'Unbekanntes Set',
                              imageUrl: cardProvider.cardData!['image_uris']?['small'],
                              manaCost: cardProvider.cardData!['mana_cost'],
                            );
                            _addCard(card);
                            Navigator.pop(context);
                          },
                          child: Text('Zur Liste hinzufügen'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Abbrechen'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: card.selected,
                          onChanged: (value) {
                            setState(() {
                              card.selected = value ?? false;
                            });
                          },
                        ),
                        if (card.imageUrl != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Image.network(
                              card.imageUrl!,
                              width: 60,
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(card.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(card.subject),
                              Text('Set: ${card.set}'),
                              if (card.manaCost != null) Text('Mana: ${card.manaCost}'),
                            ],
                          ),
                        ),
                        Text(card.date.split('T').first, style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _showAddDialog, child: Text('Add')),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: _deleteSelected, child: Text('Delete')),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: _selectAll, child: Text('Select All')),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
