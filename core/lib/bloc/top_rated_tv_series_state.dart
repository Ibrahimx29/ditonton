part of 'top_rated_tv_series_bloc.dart';

class TopRatedTvSeriesState extends Equatable {
  final RequestState state;
  final List<Serial> tvSeries;
  final String message;

  const TopRatedTvSeriesState({
    required this.state,
    required this.tvSeries,
    required this.message,
  });

  factory TopRatedTvSeriesState.initial() {
    return const TopRatedTvSeriesState(
      state: RequestState.Empty,
      tvSeries: [],
      message: '',
    );
  }

  TopRatedTvSeriesState copyWith({
    RequestState? state,
    List<Serial>? tvSeries,
    String? message,
  }) {
    return TopRatedTvSeriesState(
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
