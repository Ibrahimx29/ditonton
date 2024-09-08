import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_series_list_event.dart';
part 'tv_series_list_state.dart';

class TvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesListBloc({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  }) : super(TvSeriesListState.initial()) {
    on<FetchNowPlayingTvSeries>(_onFetchNowPlayingTvSeries);
    on<FetchPopularTvSeries>(_onFetchPopularTvSeries);
    on<FetchTopRatedTvSeries>(_onFetchTopRatedTvSeries);
  }

  Future<void> _onFetchNowPlayingTvSeries(
    FetchNowPlayingTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(state.copyWith(nowPlayingState: RequestState.Loading));
    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvSeries) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvSeries: tvSeries,
        ));
      },
    );
  }

  Future<void> _onFetchPopularTvSeries(
    FetchPopularTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(state.copyWith(popularTvSeriesState: RequestState.Loading));
    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          popularTvSeriesState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvSeries) {
        emit(state.copyWith(
          popularTvSeriesState: RequestState.Loaded,
          popularTvSeries: tvSeries,
        ));
      },
    );
  }

  Future<void> _onFetchTopRatedTvSeries(
    FetchTopRatedTvSeries event,
    Emitter<TvSeriesListState> emit,
  ) async {
    emit(state.copyWith(topRatedTvSeriesState: RequestState.Loading));
    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          topRatedTvSeriesState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvSeries) {
        emit(state.copyWith(
          topRatedTvSeriesState: RequestState.Loaded,
          topRatedTvSeries: tvSeries,
        ));
      },
    );
  }
}
