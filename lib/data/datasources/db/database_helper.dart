import 'package:scyject/data/models/project_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblProject = 'project';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/scyject.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblProject (
        id INTEGER PRIMARY KEY,
        title TEXT,
        subtitle TEXT,
        date TEXT
      );
    ''');
  }

  Future<int> insertProject(ProjectTable project) async {
    final db = await database;
    return await db!.insert(_tblProject, project.toJson());
  }

  Future<int> removeProject(ProjectTable project) async {
    final db = await database;
    return await db!.delete(_tblProject, where: 'id = ?');
  }

  Future<List<Map<String, dynamic>>> getListProject() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblProject);
    return results;
  }
}
