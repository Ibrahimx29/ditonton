import 'package:core/core.dart';
import 'package:core/data/datasources/db/tv_series_database_helper.dart';
import 'package:core/data/models/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlist(TvSeriesTable tv_series);
  Future<String> removeWatchlist(TvSeriesTable tv_series);
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final TvSeriesDatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvSeriesTable tv_series) async {
    try {
      await databaseHelper.insertWatchlist(tv_series);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable tv_series) async {
    try {
      await databaseHelper.removeWatchlist(tv_series);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }
}
