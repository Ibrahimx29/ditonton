import 'package:flutter_test/flutter_test.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_series_detail.dart';

void main() {
  const tGenre = Genre(id: 1, name: 'Action');

  const tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [tGenre],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    name: 'name',
    voteAverage: 8.5,
    voteCount: 1000,
  );

  test('should have correct props', () {
    expect(tTvSeriesDetail.props, [
      false,
      'backdropPath',
      [tGenre],
      1,
      'originalName',
      'overview',
      'posterPath',
      'firstAirDate',
      'name',
      8.5,
      1000,
    ]);
  });

  test('should be equal when properties are the same', () {
    const anotherTvSeriesDetail = TvSeriesDetail(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [tGenre],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      numberOfEpisodes: 10,
      numberOfSeasons: 1,
      name: 'name',
      voteAverage: 8.5,
      voteCount: 1000,
    );

    expect(tTvSeriesDetail, anotherTvSeriesDetail);
  });

  test('should not be equal when properties are different', () {
    const differentGenre = Genre(id: 2, name: 'Comedy');

    const differentTvSeriesDetail = TvSeriesDetail(
      adult: true,
      backdropPath: 'differentBackdropPath',
      genres: [differentGenre],
      id: 2,
      originalName: 'differentOriginalName',
      overview: 'differentOverview',
      posterPath: 'differentPosterPath',
      firstAirDate: 'differentFirstAirDate',
      numberOfEpisodes: 20,
      numberOfSeasons: 2,
      name: 'differentName',
      voteAverage: 7.0,
      voteCount: 500,
    );

    expect(tTvSeriesDetail, isNot(differentTvSeriesDetail));
  });
}
