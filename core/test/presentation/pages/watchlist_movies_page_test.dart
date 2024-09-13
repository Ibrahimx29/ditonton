import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/bloc/watchlist_movies_bloc.dart';
import 'package:core/bloc/watchlist_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

class MockWatchlistTvSeriesBloc
    extends MockBloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState>
    implements WatchlistTvSeriesBloc {}

class WatchlistMoviesStateFake extends Fake implements WatchlistMoviesState {}

class WatchlistMoviesEventFake extends Fake implements WatchlistMoviesEvent {}

class WatchlistTvSeriesStateFake extends Fake
    implements WatchlistTvSeriesState {}

class WatchlistTvSeriesEventFake extends Fake
    implements WatchlistTvSeriesEvent {}

void main() {
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;
  late MockWatchlistTvSeriesBloc mockWatchlistTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistMoviesStateFake());
    registerFallbackValue(WatchlistMoviesEventFake());
    registerFallbackValue(WatchlistTvSeriesStateFake());
    registerFallbackValue(WatchlistTvSeriesEventFake());
  });

  setUp(() {
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
    mockWatchlistTvSeriesBloc = MockWatchlistTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMoviesBloc>.value(value: mockWatchlistMoviesBloc),
        BlocProvider<WatchlistTvSeriesBloc>.value(
            value: mockWatchlistTvSeriesBloc),
      ],
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state).thenReturn(
      WatchlistMoviesState.initial().copyWith(state: RequestState.Loading),
    );
    when(() => mockWatchlistTvSeriesBloc.state).thenReturn(
      WatchlistTvSeriesState.initial().copyWith(state: RequestState.Loading),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state).thenReturn(
      WatchlistMoviesState.initial().copyWith(
        state: RequestState.Loaded,
        movies: <Movie>[],
      ),
    );
    when(() => mockWatchlistTvSeriesBloc.state).thenReturn(
      WatchlistTvSeriesState.initial().copyWith(
        state: RequestState.Loaded,
        tvSeries: <Serial>[],
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistMoviesBloc.state).thenReturn(
      WatchlistMoviesState.initial().copyWith(
        state: RequestState.Error,
        message: 'Error message',
      ),
    );
    when(() => mockWatchlistTvSeriesBloc.state).thenReturn(
      WatchlistTvSeriesState.initial().copyWith(
        state: RequestState.Error,
        message: 'Error message',
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
