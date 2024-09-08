part of 'tv_series_list_bloc.dart';

class TvSeriesListState extends Equatable {
  final RequestState nowPlayingState;
  final RequestState popularTvSeriesState;
  final RequestState topRatedTvSeriesState;
  final List<Serial> nowPlayingTvSeries;
  final List<Serial> popularTvSeries;
  final List<Serial> topRatedTvSeries;
  final String message;

  const TvSeriesListState({
    required this.nowPlayingState,
    required this.popularTvSeriesState,
    required this.topRatedTvSeriesState,
    required this.nowPlayingTvSeries,
    required this.popularTvSeries,
    required this.topRatedTvSeries,
    required this.message,
  });

  factory TvSeriesListState.initial() {
    return const TvSeriesListState(
      nowPlayingState: RequestState.Empty,
      popularTvSeriesState: RequestState.Empty,
      topRatedTvSeriesState: RequestState.Empty,
      nowPlayingTvSeries: [],
      popularTvSeries: [],
      topRatedTvSeries: [],
      message: '',
    );
  }

  TvSeriesListState copyWith({
    RequestState? nowPlayingState,
    RequestState? popularTvSeriesState,
    RequestState? topRatedTvSeriesState,
    List<Serial>? nowPlayingTvSeries,
    List<Serial>? popularTvSeries,
    List<Serial>? topRatedTvSeries,
    String? message,
  }) {
    return TvSeriesListState(
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularTvSeriesState: popularTvSeriesState ?? this.popularTvSeriesState,
      topRatedTvSeriesState:
          topRatedTvSeriesState ?? this.topRatedTvSeriesState,
      nowPlayingTvSeries: nowPlayingTvSeries ?? this.nowPlayingTvSeries,
      popularTvSeries: popularTvSeries ?? this.popularTvSeries,
      topRatedTvSeries: topRatedTvSeries ?? this.topRatedTvSeries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        nowPlayingState,
        popularTvSeriesState,
        topRatedTvSeriesState,
        nowPlayingTvSeries,
        popularTvSeries,
        topRatedTvSeries,
        message,
      ];
}
