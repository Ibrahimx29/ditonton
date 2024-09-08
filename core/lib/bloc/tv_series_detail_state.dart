part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailState extends Equatable {
  final RequestState tvSeriesState;
  final RequestState recommendationState;
  final TvSeriesDetail? tvSeries;
  final List<Serial> recommendations;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const TvSeriesDetailState({
    this.tvSeries,
    this.recommendations = const [],
    this.tvSeriesState = RequestState.Empty,
    this.recommendationState = RequestState.Empty,
    this.message = '',
    this.isAddedToWatchlist = false,
    this.watchlistMessage = '',
  });

  TvSeriesDetailState copyWith({
    TvSeriesDetail? tvSeries,
    List<Serial>? recommendations,
    RequestState? tvSeriesState,
    RequestState? recommendationState,
    String? message,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return TvSeriesDetailState(
      tvSeries: tvSeries ?? this.tvSeries,
      recommendations: recommendations ?? this.recommendations,
      tvSeriesState: tvSeriesState ?? this.tvSeriesState,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
        tvSeries,
        recommendations,
        tvSeriesState,
        recommendationState,
        message,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}
