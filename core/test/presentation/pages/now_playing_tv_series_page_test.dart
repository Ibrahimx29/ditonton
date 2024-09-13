import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/now_playing_tv_series_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNowPlayingTvSeriesBloc
    extends MockBloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState>
    implements NowPlayingTvSeriesBloc {}

class NowPlayingTvSeriesStateFake extends Fake
    implements NowPlayingTvSeriesState {}

class NowPlayingTvSeriesEventFake extends Fake
    implements NowPlayingTvSeriesEvent {}

void main() {
  late MockNowPlayingTvSeriesBloc mockNowPlayingTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(NowPlayingTvSeriesStateFake());
    registerFallbackValue(NowPlayingTvSeriesEventFake());
  });

  setUp(() {
    mockNowPlayingTvSeriesBloc = MockNowPlayingTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvSeriesBloc>.value(
      value: mockNowPlayingTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvSeriesBloc.state).thenReturn(
      NowPlayingTvSeriesState.initial().copyWith(state: RequestState.Loading),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester
        .pumpWidget(_makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvSeriesBloc.state).thenReturn(
      NowPlayingTvSeriesState.initial().copyWith(
        state: RequestState.Loaded,
        tvSeries: <Serial>[],
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester
        .pumpWidget(_makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvSeriesBloc.state).thenReturn(
      NowPlayingTvSeriesState.initial().copyWith(
        state: RequestState.Error,
        message: 'Error message',
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester
        .pumpWidget(_makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
