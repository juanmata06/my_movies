import 'package:my_movies/domain/entities/movie.dart';
import 'package:my_movies/domain/datasources/movies_datasource.dart';
import 'package:my_movies/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository{
  final MoviesDataSource datasource;
  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}