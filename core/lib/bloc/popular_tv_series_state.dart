part of 'popular_tv_series_bloc.dart';

class PopularTvSeriesState extends Equatable {
  final RequestState state;
  final List<Serial> tvSeries;
  final String message;

  const PopularTvSeriesState({
    required this.state,
    required this.tvSeries,
    required this.message,
  });

  factory PopularTvSeriesState.initial() {
    return const PopularTvSeriesState(
      state: RequestState.Empty,
      tvSeries: [],
      message: '',
    );
  }

  PopularTvSeriesState copyWith({
    RequestState? state,
    List<Serial>? tvSeries,
    String? message,
  }) {
    return PopularTvSeriesState(
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
