import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListState.initial()) {
    on<FetchNowPlayingMovies>(_onFetchNowPlayingMovies);
    on<FetchPopularMovies>(_onFetchPopularMovies);
    on<FetchTopRatedMovies>(_onFetchTopRatedMovies);
  }

  Future<void> _onFetchNowPlayingMovies(
    FetchNowPlayingMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(nowPlayingState: RequestState.Loading));
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Error,
          message: failure.message,
        ));
      },
      (movies) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: movies,
        ));
      },
    );
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(popularMoviesState: RequestState.Loading));
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          popularMoviesState: RequestState.Error,
          message: failure.message,
        ));
      },
      (movies) {
        emit(state.copyWith(
          popularMoviesState: RequestState.Loaded,
          popularMovies: movies,
        ));
      },
    );
  }

  Future<void> _onFetchTopRatedMovies(
    FetchTopRatedMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(topRatedMoviesState: RequestState.Loading));
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          topRatedMoviesState: RequestState.Error,
          message: failure.message,
        ));
      },
      (movies) {
        emit(state.copyWith(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: movies,
        ));
      },
    );
  }
}
