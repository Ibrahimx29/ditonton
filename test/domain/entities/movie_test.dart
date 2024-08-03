import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 8.5,
    voteCount: 1000,
  );

  final tWatchlistMovie = Movie.watchlist(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    title: 'title',
  );

  test('should have correct props for normal constructor', () {
    expect(tMovie.props, [
      false,
      'backdropPath',
      [1, 2, 3],
      1,
      'originalTitle',
      'overview',
      1.0,
      'posterPath',
      'releaseDate',
      'title',
      false,
      8.5,
      1000,
    ]);
  });

  test('should have correct props for watchlist constructor', () {
    expect(tWatchlistMovie.props, [
      null,
      null,
      null,
      1,
      null,
      'overview',
      null,
      'posterPath',
      null,
      'title',
      null,
      null,
      null,
    ]);
  });

  test('should be equal when properties are the same', () {
    final anotherMovie = Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 8.5,
      voteCount: 1000,
    );

    expect(tMovie, anotherMovie);
  });

  test('should not be equal when properties are different', () {
    final differentMovie = Movie(
      adult: true,
      backdropPath: 'differentBackdropPath',
      genreIds: [4, 5, 6],
      id: 2,
      originalTitle: 'differentOriginalTitle',
      overview: 'differentOverview',
      popularity: 2.0,
      posterPath: 'differentPosterPath',
      releaseDate: 'differentReleaseDate',
      title: 'differentTitle',
      video: true,
      voteAverage: 9.0,
      voteCount: 2000,
    );

    expect(tMovie, isNot(differentMovie));
  });
}
