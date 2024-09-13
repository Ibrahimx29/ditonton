import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/top_rated_tv_series_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopRatedTvSeriesBloc
    extends MockBloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState>
    implements TopRatedTvSeriesBloc {}

class TopRatedTvSeriesStateFake extends Fake implements TopRatedTvSeriesState {}

class TopRatedTvSeriesEventFake extends Fake implements TopRatedTvSeriesEvent {}

void main() {
  late MockTopRatedTvSeriesBloc mockTopRatedTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedTvSeriesStateFake());
    registerFallbackValue(TopRatedTvSeriesEventFake());
  });

  setUp(() {
    mockTopRatedTvSeriesBloc = MockTopRatedTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>.value(
      value: mockTopRatedTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state).thenReturn(
      TopRatedTvSeriesState.initial().copyWith(state: RequestState.Loading),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state).thenReturn(
      TopRatedTvSeriesState.initial().copyWith(
        state: RequestState.Loaded,
        tvSeries: <Serial>[],
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvSeriesBloc.state).thenReturn(
      TopRatedTvSeriesState.initial().copyWith(
        state: RequestState.Error,
        message: 'Error message',
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
