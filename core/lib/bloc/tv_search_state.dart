part of 'tv_search_bloc.dart';

class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends TvSearchState {}

class SearchLoading extends TvSearchState {}

class SearchError extends TvSearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends TvSearchState {
  final List<Serial> result;

  const SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
