import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_movies/presentation/provider/providers_exports.dart';
import 'package:my_movies/presentation/widgets/widgets_exports.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPageNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {

    final carouselMovies = ref.watch(moviesCarouselProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index){
            return Column(children: [
              MoviesCarousel(movies: carouselMovies),
              MoviesAndInfoCarousel(
                movies: nowPlayingMovies,
                title: 'In theaters',
                subtitle: 'Monday 17',
                loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPageNowPlayingMovies(),
              ),
              MoviesAndInfoCarousel(
                movies: nowPlayingMovies,
                title: 'Very soon',
                subtitle: 'Next month',
                loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPageNowPlayingMovies(),
              ),
              MoviesAndInfoCarousel(
                movies: nowPlayingMovies,
                title: 'Most populars',
                // subtitle: '',
                loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPageNowPlayingMovies(),
              ),
              MoviesAndInfoCarousel(
                movies: nowPlayingMovies,
                title: 'Highest rated',
                subtitle: 'TMDB',
                loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPageNowPlayingMovies(),
              ),
              const SizedBox(height: 10)
            ]);
          },
          childCount: 1
        ))
      ]
    );
  }
}
