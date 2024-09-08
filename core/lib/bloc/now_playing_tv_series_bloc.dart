import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvSeriesBloc({required this.getNowPlayingTvSeries})
      : super(NowPlayingTvSeriesState.initial()) {
    on<FetchNowPlayingTvSeries>(_onFetchNowPlayingTvSeries);
  }

  Future<void> _onFetchNowPlayingTvSeries(
    FetchNowPlayingTvSeries event,
    Emitter<NowPlayingTvSeriesState> emit,
  ) async {
    emit(state.copyWith(state: RequestState.Loading));
    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvSeries) {
        emit(state.copyWith(
          state: RequestState.Loaded,
          tvSeries: tvSeries,
        ));
      },
    );
  }
}
