import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSerial = Serial(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 8.5,
    voteCount: 1000,
  );

  final tWatchlistSerial = Serial.watchlist(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
  );

  test('should have correct props for normal constructor', () {
    expect(tSerial.props, [
      false,
      'backdropPath',
      [1, 2, 3],
      1,
      ['US'],
      'en',
      'originalName',
      'overview',
      1.0,
      'posterPath',
      'firstAirDate',
      'name',
      8.5,
      1000,
    ]);
  });

  test('should have correct props for watchlist constructor', () {
    expect(tWatchlistSerial.props, [
      null,
      null,
      null,
      1,
      null,
      null,
      null,
      'overview',
      null,
      'posterPath',
      null,
      'name',
      null,
      null,
    ]);
  });

  test('should be equal when properties are the same', () {
    final anotherSerial = Serial(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originCountry: ['US'],
      originalLanguage: 'en',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      name: 'name',
      voteAverage: 8.5,
      voteCount: 1000,
    );

    expect(tSerial, anotherSerial);
  });

  test('should not be equal when properties are different', () {
    final differentSerial = Serial(
      adult: true,
      backdropPath: 'differentBackdropPath',
      genreIds: [4, 5, 6],
      id: 2,
      originCountry: ['UK'],
      originalLanguage: 'fr',
      originalName: 'differentOriginalName',
      overview: 'differentOverview',
      popularity: 2.0,
      posterPath: 'differentPosterPath',
      firstAirDate: 'differentFirstAirDate',
      name: 'differentName',
      voteAverage: 9.0,
      voteCount: 2000,
    );

    expect(tSerial, isNot(differentSerial));
  });
}
