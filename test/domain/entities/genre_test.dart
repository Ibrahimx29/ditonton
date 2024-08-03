import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenre = Genre(
    id: 1,
    name: 'Action',
  );

  test('should have correct props', () {
    expect(tGenre.props, [1, 'Action']);
  });

  test('should be equal when properties are the same', () {
    final anotherTGenre = Genre(
      id: 1,
      name: 'Action',
    );

    expect(tGenre, anotherTGenre);
  });

  test('should not be equal when properties are different', () {
    final differentGenre = Genre(
      id: 2,
      name: 'Comedy',
    );

    expect(tGenre, isNot(differentGenre));
  });
}
