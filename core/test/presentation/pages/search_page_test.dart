import 'package:bloc_test/bloc_test.dart';
import 'package:core/bloc/search_bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class SearchStateFake extends Fake implements SearchState {}

class SearchEventFake extends Fake implements SearchEvent {}

void main() {
  late MockSearchBloc mockSearchBloc;

  setUpAll(() {
    registerFallbackValue(SearchStateFake());
    registerFallbackValue(SearchEventFake());
  });

  setUp(() {
    mockSearchBloc = MockSearchBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchBloc>.value(
      value: mockSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSearchBloc.state).thenReturn(SearchLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(progressBarFinder, findsOneWidget);
    expect(find.ancestor(of: progressBarFinder, matching: find.byType(Center)),
        findsOneWidget);
  });

  testWidgets('Page should display list of movies when data is loaded',
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

    when(() => mockSearchBloc.state).thenReturn(SearchHasData([movie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchBloc.state)
        .thenReturn(const SearchError('Error message'));

    final textFinder = find.text('Error message');

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should show an empty container when initial state is empty',
      (WidgetTester tester) async {
    when(() => mockSearchBloc.state).thenReturn(SearchEmpty());

    final containerFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(containerFinder, findsOneWidget);
  });

  testWidgets('TextField should trigger search when input changes',
      (WidgetTester tester) async {
    when(() => mockSearchBloc.state).thenReturn(SearchEmpty());

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    await tester.enterText(textFieldFinder, 'test query');

    verify(() => mockSearchBloc.add(const OnQueryChanged('test query')))
        .called(1);
  });
}
