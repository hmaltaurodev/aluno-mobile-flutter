import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'helpers/helpers.dart';

class DataBase {
  static const String _dataBaseName = 'aluno_mobile.db';
  static const int _version = 1;

  static final DataBase _instance = DataBase.internal();
  factory DataBase() => _instance;
  DataBase.internal();

  Database? _database;

  Future<Database> get getDatabase async {
    _database ??= await init();
    return _database!;
  }

  Future<Database> init() async {
    final String path = await getDatabasesPath();
    final String pathDatabase = join(path, _dataBaseName);

    return await openDatabase(
      pathDatabase,
      version: _version,
      onCreate: (Database database, int version) async {
        await database.execute(studentSqlCreate);
        await database.execute(teacherSqlCreate);
        await database.execute(userSqlCreate);
        await database.execute(disciplineSqlCreate);
        await database.execute(courseSqlCreate);
        await database.execute(curriculumGrideSqlCreate);
        await database.execute(curriculumGrideDisciplineSqlCreate);
        await database.execute(classroomSqlCreate);
        await database.execute(classroomStudentSqlCreate);
        await database.execute(frequencySqlCreate);
        await database.execute(gradeSqlCreate);
      }
    );
  }

  void close() async {
    (await getDatabase).close();
  }
}
