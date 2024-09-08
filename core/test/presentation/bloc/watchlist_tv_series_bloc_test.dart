import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/watchlist_tv_series_bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
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
    expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesState.initial());
  });

  group('watchlist tv series', () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emit [Loading, HasData] when watchlist tv series data is successfully fetched',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesState.initial().copyWith(
          state: RequestState.Loading,
        ),
        WatchlistTvSeriesState.initial().copyWith(
          state: RequestState.Loaded,
          tvSeries: tTvSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emit [Loading, Error] when watchlist tv series data fetching fails',
      build: () {
        when(mockGetWatchlistTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to fetch data')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesState.initial().copyWith(
          state: RequestState.Loading,
        ),
        WatchlistTvSeriesState.initial().copyWith(
          state: RequestState.Error,
          message: 'Failed to fetch data',
        ),
      ],
      verify: (_) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );
  });
}
