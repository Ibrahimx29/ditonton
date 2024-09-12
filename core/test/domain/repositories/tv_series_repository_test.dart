import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
  });

  final tTvSeries = <Serial>[];
  const tTvSeriesDetail = TvSeriesDetail(
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
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      final result = await mockTvSeriesRepository.getNowPlayingTvSeries();
      // assert
      expect(result, const Left(ServerFailure('Server Failure')));
    });
  });

  group('getMovieDetail', () {
    const tId = 1;

    test('should return movie detail when the call is successful', () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesDetail(tId))
          .thenAnswer((_) async => const Right(tTvSeriesDetail));
      // act
      final result = await mockTvSeriesRepository.getTvSeriesDetail(tId);
      // assert
      expect(result, const Right(tTvSeriesDetail));
    });

    test('should return failure when the call is unsuccessful', () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesDetail(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      final result = await mockTvSeriesRepository.getTvSeriesDetail(tId);
      // assert
      expect(result, const Left(ServerFailure('Server Failure')));
    });
  });
}
