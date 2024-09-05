part of 'watchlist_movies_bloc.dart';

class WatchlistMoviesState extends Equatable {
  final RequestState state;
  final List<Movie> movies;
  final String message;

  const WatchlistMoviesState({
    required this.state,
    required this.movies,
    required this.message,
  });

  factory WatchlistMoviesState.initial() {
    return const WatchlistMoviesState(
      state: RequestState.Empty,
      movies: [],
      message: '',
    );
  }

  WatchlistMoviesState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return WatchlistMoviesState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        state,
        movies,
        message,
      ];
}
