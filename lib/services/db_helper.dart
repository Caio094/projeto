import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/lista.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'listas.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE listas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT
      )
    ''');
  }

  Future<int> insertLista(Lista lista) async {
    final db = await database;
    return await db.insert('listas', lista.toMap());
  }

  Future<List<Lista>> getListas() async {
    final db = await database;
    var result = await db.query('listas');
    return result.map((e) => Lista.fromMap(e)).toList();
  }
}
