import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/tv_series_list_bloc.dart';
import 'package:core/core.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvSeriesListBloc
    extends MockBloc<TvSeriesListEvent, TvSeriesListState>
    implements TvSeriesListBloc {}

class TvSeriesListStateFake extends Fake implements TvSeriesListState {}

class TvSeriesListEventFake extends Fake implements TvSeriesListEvent {}

void main() {
  late MockTvSeriesListBloc mockTvSeriesListBloc;

  setUpAll(() {
    registerFallbackValue(TvSeriesListStateFake());
    registerFallbackValue(TvSeriesListEventFake());
  });

  setUp(() {
    mockTvSeriesListBloc = MockTvSeriesListBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesListBloc>.value(
      value: mockTvSeriesListBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display center progress bar when loading now playing tv series',
      (WidgetTester tester) async {
    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState.initial()
          .copyWith(nowPlayingState: RequestState.Loading),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display Tv Series List when data is loaded for now playing tv series ',
      (WidgetTester tester) async {
    final tvSeries = Serial(
      name: 'name',
      firstAirDate: '2020-01-01',
      originCountry: const ['US'],
      originalLanguage: 'en',
      originalName: 'originalName',
      id: 1,
      overview: 'overview',
      posterPath: '/test.jpg',
      backdropPath: '/test.jpg',
      voteAverage: 8.0,
      voteCount: 1000,
      adult: false,
      genreIds: const [1],
      popularity: 1.0,
    );

    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState.initial().copyWith(
        nowPlayingState: RequestState.Loaded,
        nowPlayingTvSeries: [tvSeries],
      ),
    );

    final tvSeriesListFinder = find.byType(TvSeriesList);

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));

    expect(tvSeriesListFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display error text when error occurs in now playing tv series',
      (WidgetTester tester) async {
    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState.initial().copyWith(
        nowPlayingState: RequestState.Error,
        message: 'Failed',
      ),
    );

    final errorTextFinder = find.byKey(const Key('now_playing_error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));

    expect(errorTextFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display center progress bar when loading popular tv series',
      (WidgetTester tester) async {
    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState.initial()
          .copyWith(popularTvSeriesState: RequestState.Loading),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display Tv Series List when data is loaded for popular tv series',
      (WidgetTester tester) async {
    final tvSeries = Serial(
      name: 'name',
      firstAirDate: '2020-01-01',
      originCountry: const ['US'],
      originalLanguage: 'en',
      originalName: 'originalName',
      id: 1,
      overview: 'overview',
      posterPath: '/test.jpg',
      backdropPath: '/test.jpg',
      voteAverage: 8.0,
      voteCount: 1000,
      adult: false,
      genreIds: const [1],
      popularity: 1.0,
    );

    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState.initial().copyWith(
        popularTvSeriesState: RequestState.Loaded,
        popularTvSeries: [tvSeries],
      ),
    );

    final tvSeriesListFinder = find.byType(TvSeriesList);

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));

    expect(tvSeriesListFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display error text when error occurs in popular tv series',
      (WidgetTester tester) async {
    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState.initial().copyWith(
        popularTvSeriesState: RequestState.Error,
        message: 'Failed',
      ),
    );

    final errorTextFinder =
        find.byKey(const Key('popular_movies_error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));

    expect(errorTextFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display center progress bar when loading top rated tv series',
      (WidgetTester tester) async {
    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState.initial()
          .copyWith(topRatedTvSeriesState: RequestState.Loading),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display TvSeriesList when data is loaded for top rated tv series',
      (WidgetTester tester) async {
    final tvSeries = Serial(
      name: 'name',
      firstAirDate: '2020-01-01',
      originCountry: const ['US'],
      originalLanguage: 'en',
      originalName: 'originalName',
      id: 1,
      overview: 'overview',
      posterPath: '/test.jpg',
      backdropPath: '/test.jpg',
      voteAverage: 8.0,
      voteCount: 1000,
      adult: false,
      genreIds: const [1],
      popularity: 1.0,
    );
    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState.initial().copyWith(
        topRatedTvSeriesState: RequestState.Loaded,
        topRatedTvSeries: [tvSeries],
      ),
    );

    final tvSeriesListFinder = find.byType(TvSeriesList);

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));

    expect(tvSeriesListFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display error text when error occurs in top rated tv series',
      (WidgetTester tester) async {
    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState.initial().copyWith(
        topRatedTvSeriesState: RequestState.Error,
        message: 'Failed',
      ),
    );

    final errorTextFinder =
        find.byKey(const Key('top_rated_movies_error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TvSeriesPage()));

    expect(errorTextFinder, findsOneWidget);
  });
}
