import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/tv_series_detail_bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetTvSeriesWatchListStatus,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetTvSeriesWatchListStatus mockGetWatchlistStatus;
  late MockSaveTvSeriesWatchlist mockSaveWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistStatus = MockGetTvSeriesWatchListStatus();
    mockSaveWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveWatchlist = MockRemoveTvSeriesWatchlist();
    tvSeriesDetailBloc = TvSeriesDetailBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;
  final tTvSeriesList = <Serial>[testTvSeries];
  final tTvSeriesDetail = testTvSeriesDetail;

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesList));
  }

  group('Get Tv Series Detail', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        _arrangeUsecase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        const TvSeriesDetailState(
          tvSeriesState: RequestState.Loading,
        ),
        TvSeriesDetailState(
          tvSeries: tTvSeriesDetail,
          recommendations: tTvSeriesList,
          tvSeriesState: RequestState.Loaded,
          recommendationState: RequestState.Loaded,
        ),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Loading, Error] when fetching tv series detail fails',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        const TvSeriesDetailState(
          tvSeriesState: RequestState.Loading,
        ),
        const TvSeriesDetailState(
          tvSeriesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should update watchlist status when tv series is added to watchlist successfully',
      build: () {
        when(mockSaveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testTvSeriesDetail)),
      expect: () => [
        // Directly check the final state
        const TvSeriesDetailState(
          isAddedToWatchlist: true,
          watchlistMessage: 'Added to Watchlist',
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should update watchlist status when movie is removed from watchlist successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testTvSeriesDetail)),
      expect: () => [
        // Directly check the final state
        const TvSeriesDetailState(
          isAddedToWatchlist: false,
          watchlistMessage: 'Removed from Watchlist',
        ),
      ],
    );
  });

  group('on Error', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Error] when data is unsuccessful',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        const TvSeriesDetailState(
          tvSeriesState: RequestState.Loading,
        ),
        const TvSeriesDetailState(
          tvSeriesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}
