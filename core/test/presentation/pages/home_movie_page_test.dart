import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/movie_list_bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieListBloc extends MockBloc<MovieListEvent, MovieListState>
    implements MovieListBloc {}

class MovieListStateFake extends Fake implements MovieListState {}

class MovieListEventFake extends Fake implements MovieListEvent {}

void main() {
  late MockMovieListBloc mockMovieListBloc;

  setUpAll(() {
    registerFallbackValue(MovieListStateFake());
    registerFallbackValue(MovieListEventFake());
  });

  setUp(() {
    mockMovieListBloc = MockMovieListBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieListBloc>.value(
      value: mockMovieListBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display center progress bar when loading now playing movies',
      (WidgetTester tester) async {
    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState.initial().copyWith(nowPlayingState: RequestState.Loading),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display MovieList when data is loaded for now playing movies',
      (WidgetTester tester) async {
    final movie = Movie(
      id: 1,
      title: 'title',
      overview: 'overview',
      posterPath: '/test.jpg',
      backdropPath: '/test.jpg',
      voteAverage: 8.0,
      voteCount: 1000,
      releaseDate: '2020-01-01',
      adult: false,
      genreIds: const [1],
      originalTitle: 'originalTitle',
      popularity: 1.0,
      video: false,
    );

    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState.initial().copyWith(
        nowPlayingState: RequestState.Loaded,
        nowPlayingMovies: [movie],
      ),
    );

    final movieListFinder = find.byType(MovieList);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(movieListFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display error text when error occurs in now playing movies',
      (WidgetTester tester) async {
    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState.initial().copyWith(
        nowPlayingState: RequestState.Error,
        message: 'Failed',
      ),
    );

    final errorTextFinder = find.byKey(const Key('now_playing_error_message'));

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(errorTextFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display center progress bar when loading popular movies',
      (WidgetTester tester) async {
    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState.initial()
          .copyWith(popularMoviesState: RequestState.Loading),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display MovieList when data is loaded for popular movies',
      (WidgetTester tester) async {
    final movie = Movie(
      id: 1,
      title: 'title',
      overview: 'overview',
      posterPath: '/test.jpg',
      backdropPath: '/test.jpg',
      voteAverage: 8.0,
      voteCount: 1000,
      releaseDate: '2020-01-01',
      adult: false,
      genreIds: const [1],
      originalTitle: 'originalTitle',
      popularity: 1.0,
      video: false,
    );

    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState.initial().copyWith(
        popularMoviesState: RequestState.Loaded,
        popularMovies: [movie],
      ),
    );

    final movieListFinder = find.byType(MovieList);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(movieListFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display error text when error occurs in popular movies',
      (WidgetTester tester) async {
    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState.initial().copyWith(
        popularMoviesState: RequestState.Error,
        message: 'Failed',
      ),
    );

    final errorTextFinder =
        find.byKey(const Key('popular_movies_error_message'));

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(errorTextFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display center progress bar when loading top rated movies',
      (WidgetTester tester) async {
    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState.initial()
          .copyWith(topRatedMoviesState: RequestState.Loading),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display MovieList when data is loaded for top rated movies',
      (WidgetTester tester) async {
    final movie = Movie(
      id: 1,
      title: 'title',
      overview: 'overview',
      posterPath: '/test.jpg',
      backdropPath: '/test.jpg',
      voteAverage: 8.0,
      voteCount: 1000,
      releaseDate: '2020-01-01',
      adult: false,
      genreIds: const [1],
      originalTitle: 'originalTitle',
      popularity: 1.0,
      video: false,
    );

    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState.initial().copyWith(
        topRatedMoviesState: RequestState.Loaded,
        topRatedMovies: [movie],
      ),
    );

    final movieListFinder = find.byType(MovieList);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(movieListFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display error text when error occurs in top rated movies',
      (WidgetTester tester) async {
    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState.initial().copyWith(
        topRatedMoviesState: RequestState.Error,
        message: 'Failed',
      ),
    );

    final errorTextFinder =
        find.byKey(const Key('top_rated_movies_error_message'));

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(errorTextFinder, findsOneWidget);
  });
}
