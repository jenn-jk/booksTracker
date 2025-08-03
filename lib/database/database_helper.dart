import 'package:books_tracker/main.dart';
import 'package:books_tracker/models/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // properties
  static const _databaseName = "books_database.db";
  static const _databaseVersion = 1;
  static const _tableName = "books";
  static Database? _database;

  // constructor
  DatabaseHelper._privateConstructor();

  // singleton static instance
  static final instance = DatabaseHelper._privateConstructor();

  // getter
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) => _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        authors TEXT NOT NULL,
        favorite INTEGER DEFAULT 0,
        publisher TEXT,
        publishedDate TEXT,
        description TEXT,
        industryIdentifiers TEXT,
        pageCount INTEGER,
        language TEXT,
        imageLinks TEXT,
        previewLink TEXT,
        infoLink TEXT
      )
    ''');
  }

  Future<int> insert(Book book) async {
    Database db = await instance.database;
    return await db.insert(_tableName, book.toJson());
  }

  Future<List<Book>> readAll() async {
    Database db = await instance.database;
    var books = await db.query(_tableName);
    return books.isNotEmpty ? books.map((bookData) 
    => Book.fromJson(bookData)).toList() : [];
  }
}
