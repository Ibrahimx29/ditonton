import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/popular_tv_series_bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(
      getPopularTvSeries: mockGetPopularTvSeries,
    );
  });

  final tSeries = Serial(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvSeriesList = <Serial>[tSeries];

  test('initial state should be empty', () {
    expect(popularTvSeriesBloc.state, PopularTvSeriesState.initial());
  });

  group('popular tv series', () {
    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should emit [Loading, HasData] when popular tv series data is successfully fetched',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        PopularTvSeriesState.initial().copyWith(
          state: RequestState.Loading,
        ),
        PopularTvSeriesState.initial().copyWith(
          state: RequestState.Loaded,
          tvSeries: tTvSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should emit [Loading, Error] when popular tv series data fetching fails',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to fetch data')));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        PopularTvSeriesState.initial().copyWith(
          state: RequestState.Loading,
        ),
        PopularTvSeriesState.initial().copyWith(
          state: RequestState.Error,
          message: 'Failed to fetch data',
        ),
      ],
      verify: (_) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });
}
