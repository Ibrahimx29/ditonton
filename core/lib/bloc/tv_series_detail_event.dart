part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  const FetchTvSeriesDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class AddToWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeries;

  const AddToWatchlist(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class RemoveFromWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeries;

  const RemoveFromWatchlist(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class LoadWatchlistStatus extends TvSeriesDetailEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}
