import 'dart:convert';
import 'package:core/data/models/movie_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:http/io_client.dart';
import 'package:core/core.dart';
import 'package:core/data/models/movie_detail_model.dart';

import 'ssl_pinning_helper.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';
  final SSLPinningHelper sslPinningHelper;

  MovieRemoteDataSourceImpl({required this.sslPinningHelper});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    IOClient ioClient = await sslPinningHelper.createIOClient();
    final response =
        await ioClient.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    IOClient ioClient = await sslPinningHelper.createIOClient();
    final response =
        await ioClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    IOClient ioClient = await sslPinningHelper.createIOClient();
    final response =
        await ioClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    IOClient ioClient = await sslPinningHelper.createIOClient();
    final response =
        await ioClient.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));
    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    IOClient ioClient = await sslPinningHelper.createIOClient();
    final response = await ioClient
        .get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    IOClient ioClient = await sslPinningHelper.createIOClient();
    final response = await ioClient
        .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
