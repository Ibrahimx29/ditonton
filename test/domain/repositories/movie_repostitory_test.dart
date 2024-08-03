import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/common/failure.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
  });

  final tMovies = <Movie>[];
  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 8.0,
    voteCount: 2000,
  );

  group('getNowPlayingMovies', () {
    test('should return list of movies when the call is successful', () async {
      // arrange
      when(mockMovieRepository.getNowPlayingMovies())
          .thenAnswer((_) async => Right(tMovies));
      // act
      final result = await mockMovieRepository.getNowPlayingMovies();
      // assert
      expect(result, Right(tMovies));
    });

    test('should return failure when the call is unsuccessful', () async {
      // arrange
      when(mockMovieRepository.getNowPlayingMovies())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      final result = await mockMovieRepository.getNowPlayingMovies();
      // assert
      expect(result, Left(ServerFailure('Server Failure')));
    });
  });

  group('getMovieDetail', () {
    final tId = 1;

    test('should return movie detail when the call is successful', () async {
      // arrange
      when(mockMovieRepository.getMovieDetail(tId))
          .thenAnswer((_) async => Right(tMovieDetail));
      // act
      final result = await mockMovieRepository.getMovieDetail(tId);
      // assert
      expect(result, Right(tMovieDetail));
    });

    test('should return failure when the call is unsuccessful', () async {
      // arrange
      when(mockMovieRepository.getMovieDetail(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      final result = await mockMovieRepository.getMovieDetail(tId);
      // assert
      expect(result, Left(ServerFailure('Server Failure')));
    });
  });
}
