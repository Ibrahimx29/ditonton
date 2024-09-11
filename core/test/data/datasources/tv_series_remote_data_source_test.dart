import 'dart:convert';
import 'package:core/data/datasources/ssl_pinning_helper.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:core/core.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../json_reader.dart';
import 'tv_series_remote_data_source_test.mocks.dart';

@GenerateMocks([SSLPinningHelper, IOClient])
void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockSSLPinningHelper mockSSLPinningHelper;
  late MockIOClient mockIOClient;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockSSLPinningHelper = MockSSLPinningHelper();
    mockIOClient = MockIOClient();
    dataSource =
        TvSeriesRemoteDataSourceImpl(sslPinningHelper: mockSSLPinningHelper);
  });

  group('get Now Playing Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing_tv.json')))
        .tvSeriesList;

    test('should return list of tv series when the response code is 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              Response(readJson('dummy_data/now_playing_tv.json'), 200));

      final result = await dataSource.getNowPlayingTvSeries();
      expect(result, equals(tTvSeriesList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.getNowPlayingTvSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv.json')))
        .tvSeriesList;

    test('should return list of tv series when response is success (200)',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              Response(readJson('dummy_data/popular_tv.json'), 200));

      final result = await dataSource.getPopularTvSeries();
      expect(result, equals(tTvSeriesList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.getPopularTvSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv.json')))
        .tvSeriesList;

    test('should return list of tv series when response is success (200)',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              Response(readJson('dummy_data/top_rated_tv.json'), 200));

      final result = await dataSource.getTopRatedTvSeries();
      expect(result, equals(tTvSeriesList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.getTopRatedTvSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series detail', () {
    const tId = 1;
    final tTvSeriesDetail = TvSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail_tv.json')));

    test('should return tv series details when response is success (200)',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              Response(readJson('dummy_data/movie_detail_tv.json'), 200));

      final result = await dataSource.getTvSeriesDetail(tId);
      expect(result, equals(tTvSeriesDetail));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.getTvSeriesDetail(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series recommendations', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvSeriesList;
    const tId = 1;

    test(
        'should return list of Tv Series recommendations when the response code is 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async =>
              Response(readJson('dummy_data/tv_recommendations.json'), 200));

      final result = await dataSource.getTvSeriesRecommendations(tId);
      expect(result, equals(tTvSeriesList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.getTvSeriesRecommendations(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tvSeries', () {
    final tSearchResult = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_hotd_tv.json')))
        .tvSeriesList;
    const tQuery = 'House of the Dragon';

    test('should return list of Tv Series  when the response code is 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async =>
              Response(readJson('dummy_data/search_hotd_tv.json'), 200));

      final result = await dataSource.searchTvSeries(tQuery);
      expect(result, equals(tSearchResult));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      when(mockSSLPinningHelper.createIOClient())
          .thenAnswer((_) async => mockIOClient);
      when(mockIOClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => Response('Not Found', 404));

      final call = dataSource.searchTvSeries(tQuery);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
