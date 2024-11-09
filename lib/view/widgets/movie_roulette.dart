import 'package:flutter/material.dart';
import 'package:movie_roulette/blocs/movies/movie_bloc.dart';

class MovieRoulette extends StatelessWidget {
  final MovieBloc bloc;

  MovieRoulette({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.movie,
        size: 100,
        color: Colors.blueAccent,
      ),
    );
  }
}
