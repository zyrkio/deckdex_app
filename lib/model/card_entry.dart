class CardEntry {
  final int? id;
  final String name;
  final String subject;
  final String date;
  final String set;
  final String? imageUrl;
  final String? manaCost;
  bool selected;


  CardEntry({
    this.id,
    required this.name,
    required this.subject,
    required this.date,
    required this.set,
    this.imageUrl,
    this.manaCost,
    this.selected = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'subject': subject,
        'date': date,
        'set': set,
        'imageUrl': imageUrl,
        'manaCost': manaCost,
      };

  factory CardEntry.fromMap(Map<String, dynamic> map) => CardEntry(
        id: map['id'],
        name: map['name'],
        subject: map['subject'],
        date: map['date'],
        set: map['set'],
        imageUrl: map['imageUrl'],
        manaCost: map['manaCost'],
      );

  CardEntry copyWith({
    int? id,
    String? name,
    String? subject,
    String? date,
    String? set,
    String? imageUrl,
    String? manaCost,
    bool? selected,
  }) {
    return CardEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      date: date ?? this.date,
      set: set ?? this.set,
      imageUrl: imageUrl ?? this.imageUrl,
      manaCost: manaCost ?? this.manaCost,
      selected: selected ?? this.selected,
    );
  }
}
