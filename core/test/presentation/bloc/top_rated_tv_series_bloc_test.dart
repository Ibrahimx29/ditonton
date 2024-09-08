import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/top_rated_tv_series_bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(
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
    expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesState.initial());
  });

  group('top rated tv series', () {
    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should emit [Loading, HasData] when top rated tv series data is successfully fetched',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        TopRatedTvSeriesState.initial().copyWith(
          state: RequestState.Loading,
        ),
        TopRatedTvSeriesState.initial().copyWith(
          state: RequestState.Loaded,
          tvSeries: tTvSeriesList,
        ),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should emit [Loading, Error] when top rated tv series data fetching fails',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Failed to fetch data')));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        TopRatedTvSeriesState.initial().copyWith(
          state: RequestState.Loading,
        ),
        TopRatedTvSeriesState.initial().copyWith(
          state: RequestState.Error,
          message: 'Failed to fetch data',
        ),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });
}
