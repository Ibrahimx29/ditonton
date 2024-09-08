import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/tv_series_list_bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late TvSeriesListBloc tvSeriesListBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesListBloc = TvSeriesListBloc(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
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
    expect(tvSeriesListBloc.state, TvSeriesListState.initial());
  });

  group('now playing tv series', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should emit [Loading, HasData] when now playing tv series data is successfully fetched',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      expect: () => [
        TvSeriesListState.initial().copyWith(
          nowPlayingState: RequestState.Loading,
        ),
        TvSeriesListState.initial().copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvSeries: tTvSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should emit [Loading, Error] when Now Playing tv series data fetching fails',
      build: () {
        when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to fetch data')));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      expect: () => [
        TvSeriesListState.initial().copyWith(
          nowPlayingState: RequestState.Loading,
        ),
        TvSeriesListState.initial().copyWith(
          nowPlayingState: RequestState.Error,
          message: 'Failed to fetch data',
        ),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );
  });

  group('popular movies', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should emit [Loading, HasData] when popular movies data is successfully fetched',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        TvSeriesListState.initial().copyWith(
          popularTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState.initial().copyWith(
          popularTvSeriesState: RequestState.Loaded,
          popularTvSeries: tTvSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should emit [Loading, Error] when popular movies data fetching fails',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to fetch data')));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        TvSeriesListState.initial().copyWith(
          popularTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState.initial().copyWith(
          popularTvSeriesState: RequestState.Error,
          message: 'Failed to fetch data',
        ),
      ],
      verify: (_) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });

  group('top rated movies', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should emit [Loading, HasData] when top rated movies data is successfully fetched',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        TvSeriesListState.initial().copyWith(
          topRatedTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState.initial().copyWith(
          topRatedTvSeriesState: RequestState.Loaded,
          topRatedTvSeries: tTvSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should emit [Loading, Error] when top rated movies data fetching fails',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to fetch data')));
        return tvSeriesListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        TvSeriesListState.initial().copyWith(
          topRatedTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState.initial().copyWith(
          topRatedTvSeriesState: RequestState.Error,
          message: 'Failed to fetch data',
        ),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });
}
