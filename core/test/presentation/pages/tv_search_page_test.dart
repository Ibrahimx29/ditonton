import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/tv_search_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvSearchBloc extends MockBloc<TvSearchEvent, TvSearchState>
    implements TvSearchBloc {}

class TvSearchStateFake extends Fake implements TvSearchState {}

class TvSearchEventFake extends Fake implements TvSearchEvent {}

void main() {
  late MockTvSearchBloc mockTvSearchBloc;

  setUpAll(() {
    registerFallbackValue(TvSearchStateFake());
    registerFallbackValue(TvSearchEventFake());
  });

  setUp(() {
    mockTvSearchBloc = MockTvSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSearchBloc>.value(
      value: mockTvSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvSearchBloc.state).thenReturn(SearchLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TvSearchPage()));

    expect(progressBarFinder, findsOneWidget);
    expect(find.ancestor(of: progressBarFinder, matching: find.byType(Center)),
        findsOneWidget);
  });

  testWidgets('Page should display list of tv series when data is loaded',
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

    when(() => mockTvSearchBloc.state).thenReturn(SearchHasData([tvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TvSearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvSearchBloc.state)
        .thenReturn(const SearchError('Error message'));

    final textFinder = find.text('Error message');

    await tester.pumpWidget(_makeTestableWidget(const TvSearchPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should show an empty container when initial state is empty',
      (WidgetTester tester) async {
    when(() => mockTvSearchBloc.state).thenReturn(SearchEmpty());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(const TvSearchPage()));

    expect(containerFinder, findsOneWidget);
  });

  testWidgets('TextField should trigger search when input changes',
      (WidgetTester tester) async {
    when(() => mockTvSearchBloc.state).thenReturn(SearchEmpty());

    await tester.pumpWidget(_makeTestableWidget(const TvSearchPage()));

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, 'test query');

    verify(() => mockTvSearchBloc.add(const OnQueryChanged('test query')))
        .called(1);
  });
}
