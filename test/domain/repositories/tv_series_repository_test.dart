import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/common/failure.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
  });

  final tTvSeries = <Serial>[];
  final tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    voteAverage: 8.0,
    voteCount: 2000,
  );

  group('getNowPlayingTvSeries', () {
    test('should return list of movies when the call is successful', () async {
      // arrange
      when(mockTvSeriesRepository.getNowPlayingTvSeries())
          .thenAnswer((_) async => Right(tTvSeries));
      // act
      final result = await mockTvSeriesRepository.getNowPlayingTvSeries();
      // assert
      expect(result, Right(tTvSeries));
    });

    test('should return failure when the call is unsuccessful', () async {
      // arrange
      when(mockTvSeriesRepository.getNowPlayingTvSeries())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      final result = await mockTvSeriesRepository.getNowPlayingTvSeries();
      // assert
      expect(result, Left(ServerFailure('Server Failure')));
    });
  });

  group('getMovieDetail', () {
    final tId = 1;

    test('should return movie detail when the call is successful', () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesDetail(tId))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      // act
      final result = await mockTvSeriesRepository.getTvSeriesDetail(tId);
      // assert
      expect(result, Right(tTvSeriesDetail));
    });

    test('should return failure when the call is unsuccessful', () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesDetail(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      final result = await mockTvSeriesRepository.getTvSeriesDetail(tId);
      // assert
      expect(result, Left(ServerFailure('Server Failure')));
    });
  });
}
