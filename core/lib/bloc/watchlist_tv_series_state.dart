part of 'watchlist_tv_series_bloc.dart';

class WatchlistTvSeriesState extends Equatable {
  final RequestState state;
  final List<Serial> tvSeries;
  final String message;

  const WatchlistTvSeriesState({
    required this.state,
    required this.tvSeries,
    required this.message,
  });

  factory WatchlistTvSeriesState.initial() {
    return const WatchlistTvSeriesState(
      state: RequestState.Empty,
      tvSeries: [],
      message: '',
    );
  }

  WatchlistTvSeriesState copyWith({
    RequestState? state,
    List<Serial>? tvSeries,
    String? message,
  }) {
    return WatchlistTvSeriesState(
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
