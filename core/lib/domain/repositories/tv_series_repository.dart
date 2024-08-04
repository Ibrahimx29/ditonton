import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<Serial>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<Serial>>> getPopularTvSeries();
  Future<Either<Failure, List<Serial>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<Serial>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<Serial>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail movie);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Serial>>> getWatchlistTvSeries();
}
