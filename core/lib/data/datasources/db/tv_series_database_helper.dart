import 'dart:async';

import 'package:core/data/models/tv_series_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class TvSeriesDatabaseHelper {
  static TvSeriesDatabaseHelper? _databaseHelper;
  TvSeriesDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory TvSeriesDatabaseHelper() =>
      _databaseHelper ?? TvSeriesDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist_tv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton2.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: 'verysafe321',
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(TvSeriesTable tv_series) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, tv_series.toJson());
  }

  Future<int> removeWatchlist(TvSeriesTable tv_series) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [tv_series.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
