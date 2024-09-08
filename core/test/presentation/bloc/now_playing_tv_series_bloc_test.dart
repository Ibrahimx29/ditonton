import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/now_playing_tv_series_bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late NowPlayingTvSeriesBloc nowPlayingTvSeriesBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvSeriesBloc = NowPlayingTvSeriesBloc(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
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
    expect(nowPlayingTvSeriesBloc.state, NowPlayingTvSeriesState.initial());
  });

  group('now playing tv series', () {
    blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'should emit [Loading, HasData] when now playing tv series data is successfully fetched',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return nowPlayingTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      expect: () => [
        NowPlayingTvSeriesState.initial().copyWith(
          state: RequestState.Loading,
        ),
        NowPlayingTvSeriesState.initial().copyWith(
          state: RequestState.Loaded,
          tvSeries: tTvSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );

    blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'should emit [Loading, Error] when now playing tv series data fetching fails',
      build: () {
        when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to fetch data')));
        return nowPlayingTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      expect: () => [
        NowPlayingTvSeriesState.initial().copyWith(
          state: RequestState.Loading,
        ),
        NowPlayingTvSeriesState.initial().copyWith(
          state: RequestState.Error,
          message: 'Failed to fetch data',
        ),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );
  });
}
