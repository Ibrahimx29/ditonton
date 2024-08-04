import 'package:flutter_test/flutter_test.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie_detail.dart';

void main() {
  final tGenre = Genre(id: 1, name: 'Action');

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [tGenre],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 8.5,
    voteCount: 1000,
  );

  test('should have correct props', () {
    expect(tMovieDetail.props, [
      false,
      'backdropPath',
      [tGenre],
      1,
      'originalTitle',
      'overview',
      'posterPath',
      'releaseDate',
      'title',
      8.5,
      1000,
    ]);
  });

  test('should be equal when properties are the same', () {
    final anotherMovieDetail = MovieDetail(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [tGenre],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      runtime: 120,
      title: 'title',
      voteAverage: 8.5,
      voteCount: 1000,
    );

    expect(tMovieDetail, anotherMovieDetail);
  });

  test('should not be equal when properties are different', () {
    final differentMovieDetail = MovieDetail(
      adult: true,
      backdropPath: 'differentBackdropPath',
      genres: [tGenre],
      id: 2,
      originalTitle: 'differentOriginalTitle',
      overview: 'differentOverview',
      posterPath: 'differentPosterPath',
      releaseDate: 'differentReleaseDate',
      runtime: 90,
      title: 'differentTitle',
      voteAverage: 7.0,
      voteCount: 500,
    );

    expect(tMovieDetail, isNot(differentMovieDetail));
  });
}
