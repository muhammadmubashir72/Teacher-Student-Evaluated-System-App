import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final tableName = 'teacher_info';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'teacher_database.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            teacherId TEXT,
            className TEXT,
            courseName TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertTeacherInfo(
      String name, String teacherId, String className, String courseName) async {
    final Database db = await database;

    await db.insert(
      tableName,
      {
        'name': name,
        'teacherId': teacherId,
        'className': className,
        'courseName': courseName,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
