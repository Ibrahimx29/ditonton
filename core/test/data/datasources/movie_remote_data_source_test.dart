import 'dart:convert';
import 'package:core/data/datasources/ssl_pinning_helper.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:core/core.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../json_reader.dart';
import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([SSLPinningHelper, IOClient])
void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockSSLPinningHelper mockSSLPinningHelper;
  late MockIOClient mockIOClient;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockSSLPinningHelper = MockSSLPinningHelper();
    mockIOClient = MockIOClient();
    dataSource =
        MovieRemoteDataSourceImpl(sslPinningHelper: mockSSLPinningHelper);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing.json')))
        .movieList;

    test('should return list of MovieModel when the response code is 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
          .thenAnswer((_) async =>
              Response(readJson('dummy_data/now_playing.json'), 200));

      final result = await dataSource.getNowPlayingMovies();
      expect(result, equals(tMovieList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.getNowPlayingMovies();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    test('should return list of movies when response is success (200)',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
          .thenAnswer(
              (_) async => Response(readJson('dummy_data/popular.json'), 200));

      final result = await dataSource.getPopularMovies();
      expect(result, equals(tMovieList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.getPopularMovies();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test('should return list of movies when response is success (200)',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              Response(readJson('dummy_data/top_rated.json'), 200));

      final result = await dataSource.getTopRatedMovies();
      expect(result, equals(tMovieList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.getTopRatedMovies();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movies detail', () {
    const tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return movie details when response is success (200)',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              Response(readJson('dummy_data/movie_detail.json'), 200));

      final result = await dataSource.getMovieDetail(tId);
      expect(result, equals(tMovieDetail));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.getMovieDetail(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movies recommendations', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/movie_recommendations.json')))
        .movieList;
    const tId = 1;

    test(
        'should return list of Movies recommendations when the response code is 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async =>
              Response(readJson('dummy_data/movie_recommendations.json'), 200));

      final result = await dataSource.getMovieRecommendations(tId);
      expect(result, equals(tMovieList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.getMovieRecommendations(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList;
    const tQuery = 'Spiderman';

    test('should return list of Movies  when the response code is 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => Response(
              readJson('dummy_data/search_spiderman_movie.json'), 200));

      final result = await dataSource.searchMovies(tQuery);
      expect(result, equals(tSearchResult));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.searchMovies(tQuery);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
