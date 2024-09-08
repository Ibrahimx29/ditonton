part of 'now_playing_tv_series_bloc.dart';

class NowPlayingTvSeriesState extends Equatable {
  final RequestState state;
  final List<Serial> tvSeries;
  final String message;

  const NowPlayingTvSeriesState({
    required this.state,
    required this.tvSeries,
    required this.message,
  });

  factory NowPlayingTvSeriesState.initial() {
    return const NowPlayingTvSeriesState(
      state: RequestState.Empty,
      tvSeries: [],
      message: '',
    );
  }

  NowPlayingTvSeriesState copyWith({
    RequestState? state,
    List<Serial>? tvSeries,
    String? message,
  }) {
    return NowPlayingTvSeriesState(
      state: state ?? this.state,
      tvSeries: tvSeries ?? this.tvSeries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        state,
        tvSeries,
        message,
      ];
}
