import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/item.dart';
import '../models/lista.dart';

class DBHelper {
  // Nome do banco de dados
  static const String dbName = 'app_listagem.db';

  // Instância do banco de dados
  static Database? _database;

  // Obter o banco de dados
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Inicializa o banco de dados
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Criar tabela de listas
        await db.execute('''
          CREATE TABLE listas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT
          )
        ''');

        // Criar tabela de itens
        await db.execute('''
          CREATE TABLE items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            preco REAL,
            listaId INTEGER,
            FOREIGN KEY (listaId) REFERENCES listas(id)
          )
        ''');
      },
    );
  }

  // Inserir uma nova lista
  Future<int> insertLista(Lista lista) async {
    final db = await database;
    return await db.insert('listas', lista.toMap());
  }

  // Obter todas as listas
  Future<List<Lista>> getListas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('listas');
    
    return List.generate(maps.length, (i) {
      return Lista(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
      );
    });
  }

  // Deletar uma lista
  Future<void> deleteLista(int listaId) async {
    final db = await database;
    await db.delete(
      'listas',
      where: 'id = ?',
      whereArgs: [listaId],
    );
  }

  // Inserir um item
  Future<int> insertItem(int listaId, Item item) async {
    final db = await database;
    return await db.insert('items', item.toMap());
  }

  // Obter os itens de uma lista
  Future<List<Item>> getItens(int listaId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      where: 'listaId = ?',
      whereArgs: [listaId],
    );

    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        preco: maps[i]['preco'],
        listaId: maps[i]['listaId'],
      );
    });
  }

  // Deletar um item
  Future<void> deleteItem(int itemId) async {
    final db = await database;
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [itemId],
    );
  }

  // Atualizar um item
  Future<void> updateItem(Item item) async {
    final db = await database;
    await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }
}
