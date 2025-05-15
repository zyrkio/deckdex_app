import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/card_entry.dart';

class CardDatabase {
  static final CardDatabase instance = CardDatabase._init();
  static Database? _database;

  CardDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cards.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        subject TEXT,
        date TEXT,
        set TEXT,
        imageUrl TEXT,
        manaCost TEXT
      )
    ''');
  }

  Future<CardEntry> create(CardEntry card) async {
    final db = await instance.database;
    final id = await db.insert('cards', card.toMap());
    return card.copyWith(id: id);
  }

  Future<List<CardEntry>> readAllCards() async {
    final db = await instance.database;
    final result = await db.query('cards');
    return result.map((json) => CardEntry.fromMap(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('cards', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
