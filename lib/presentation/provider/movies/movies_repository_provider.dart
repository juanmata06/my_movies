import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movies/infrastructure/datasources/moviedb_datasource.dart';
import 'package:my_movies/infrastructure/repositories/movie_repository_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviesDbDatasource());
});
