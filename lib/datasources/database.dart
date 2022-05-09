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

      }
    );
  }

  void close() async {
    (await getDatabase).close();
  }
}
