part of 'popular_movies_bloc.dart';

class PopularMoviesState extends Equatable {
  final RequestState state;
  final List<Movie> movies;
  final String message;

  const PopularMoviesState({
    required this.state,
    required this.movies,
    required this.message,
  });

  factory PopularMoviesState.initial() {
    return const PopularMoviesState(
      state: RequestState.Empty,
      movies: [],
      message: '',
    );
  }

  PopularMoviesState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return PopularMoviesState(
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
