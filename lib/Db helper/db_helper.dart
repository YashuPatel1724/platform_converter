import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? _db;

  Future<Database?> get database async => _db ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'platform.db');

    return  await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''CREATE TABLE platform(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        chatConversation TEXT NOT NULL,
        profile TEXT NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL
       )''';
        db.execute(sql);
      },
    );
  }

  Future<int> addUserToDatabase({required String name,
    required String phone,
    required String chatConversation,
    required String profile,
    required String date,
    required String time,})
  async {
    final db = await database;
    String sql = '''
    INSERT INTO platform (name, phone, chatConversation, profile, date, time)
    VALUES (?, ?, ?, ?, ?, ?)
    ''';
    List args = [name, phone, chatConversation, profile, date, time];
    return await db!.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readDataFromDatabase()
  async {
    final db = await database;
    String sql = '''
    SELECT * FROM platform
    ''';
    return await db!.rawQuery(sql);
  }

  Future<int> deleteDataFromDatabase(int id)
  async {
      final db = await database;
      String sql = '''
      DELETE FROM platform WHERE id = ?
      ''';
      List args = [id];
      return await db!.rawDelete(sql,args);
  }

  Future<int> updateDataFromDatabase(String name, String phone,
      String chatConversation, String profile, int id)
  async {
    final db = await database;
    String sql = '''
    UPDATE platform SET name = ?, phone = ?, chatConversation = ?, profile = ? WHERE id = ?
    ''';
    List args = [name, phone, chatConversation, profile, id];
    return await db!.rawUpdate(sql, args);
  }

}
