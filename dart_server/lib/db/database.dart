import 'package:drift/drift.dart';

@DriftDatabase(tables: [User, Post])
class ParkingDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<User>> getAllUsers() => select(users).get();
  Future<List<Post>> getPostsByUser(int userId) {
    return (select(posts)..where((tbl) => tbl.userId.equals(userId))).get();
  }

  Future insertUser(Insertable<User> user) => into(users).insert(user);
  Future insertPost(Insertable<Post> post) => into(posts).insert(post);
}

LazyDatabase _openConnection() {
  final file = File(join(Directory.current.path, 'app.db'));
  return LazyDatabase(() async => NativeDatabase(file));
}


--------
class ParkingDatabase {
  static final ParkingDatabase instance = ParkingDatabase._internal();

  static Database? _database;

  ParkingDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/notes.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }
}

Future<void> _createDatabase(Database db, int version) async {
  return await db.execute('''
        CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          created_time INTEGER NOT NULL
        )
      ''');
}

Future close() async {
  final db = await instance.database;
  db.close();
}
