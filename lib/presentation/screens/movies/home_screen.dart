import 'package:flutter/material.dart';

import 'package:my_movies/config/constants/enviroments.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Enviroment.theMovieDbKey),
      ),
    );
  }
}