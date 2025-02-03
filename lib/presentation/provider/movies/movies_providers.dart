import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_movies/domain/entities/movie.dart';

import 'package:my_movies/presentation/provider/movies/movies_repository_provider.dart';

//* Provider that manages the "Now Playing" movies state using [MoviesNotifier] for fetching and updates.  
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

//* Definition for an asynchronous function that fetches a list of movies.
typedef MovieCallBack = Future<List<Movie>> Function({int page});

//* StateNotifier responsible for managing the list of movies. It handles pagination and state updates.
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;  
  MovieCallBack fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPageNowPlayingMovies() async {
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
  }
}