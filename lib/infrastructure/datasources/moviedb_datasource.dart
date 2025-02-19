import 'package:dio/dio.dart';

import 'package:my_movies/config/constants/enviroments.dart';
import 'package:my_movies/domain/datasources/movies_datasource.dart';
import 'package:my_movies/domain/entities/movie.dart';
import 'package:my_movies/infrastructure/mappers/movie_mapper.dart';
import 'package:my_movies/infrastructure/models/moviedb/moviedb_response.dart';

class MoviesDbDatasource extends MoviesDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'languaje': 'ex-MX'
      }
    )
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        .where((movie) => movie.posterPath != 'no-poster')
        .map((movie) => MovieMapper.movieDbToEntity(movie))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      'movie/now_playing', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      'movie/upcoming', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      'movie/popular', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      'movie/top_rated', 
      queryParameters: {
        'page': page
      }
    );
    return _jsonToMovies(response.data);
  }
}
