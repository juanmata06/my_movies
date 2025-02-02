import 'package:dio/dio.dart';

import 'package:my_movies/config/constants/enviroments.dart';
import 'package:my_movies/domain/datasources/movies_datasource.dart';
import 'package:my_movies/domain/entities/movie.dart';
import 'package:my_movies/infrastructure/mappers/movie_mapper.dart';
import 'package:my_movies/infrastructure/models/moviedb/moviedb_response.dart';

class MoviesDbDatasource extends MoviesDataSource {
  //* General configs for Dio usage
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'languaje': 'ex-MX'
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');

    //* Store the API response in a general response model
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    //* Filter and map the data into a list, which will be returned as the response
    final List<Movie> movies = movieDbResponse.results
        .where((movie) => movie.posterPath != 'no-poster')
        .map((movie) => MovieMapper.movieDbToEntity(movie))
        .toList();

    return movies;
  }
}
