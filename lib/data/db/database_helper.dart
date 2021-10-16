import 'package:restaurian/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _favoritesTable = 'favorites';

  Future<Database> _initializeDb() async {
    String path = await getDatabasesPath();
    Future<Database> db = openDatabase(
      '$path/restaurian.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_favoritesTable (
           id TEXT PRIMARY KEY,
           name TEXT NOT NULL,
           description TEXT NOT NULL,
           pictureId TEXT NOT NULL,
           city TEXT NOT NULL,
           address TEXT NOT NULL,
           rating REAL NOT NULL
          )
           ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<int> insertRestaurant(Restaurant restaurant) async {
    Database? db = await database;
    return await db!.insert(_favoritesTable, restaurant.toJson());
  }

  Future<List<Restaurant>> getRestaurants() async {
    Database? db = await database;
    List<Map<String, dynamic>> results = await db!.query(_favoritesTable);
    return results
        .map((resultJson) => Restaurant.fromJson(resultJson))
        .toList();
  }

  Future<int> removeRestaurant(String id) async {
    Database? db = await database;
    return await db!.delete(
      _favoritesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isFavorite(String id) async {
    Database? db = await database;
    List<Map<String, dynamic>> results = await db!.rawQuery(
      'SELECT COUNT(id) AS count FROM $_favoritesTable WHERE id = ?',
      [id],
    );
    return results[0]['count'] as int == 1;
  }
}
