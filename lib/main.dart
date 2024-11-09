import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_roulette/blocs/genres/genre_bloc.dart';
import 'package:movie_roulette/blocs/movies/movie_bloc.dart';
import 'package:movie_roulette/data/repositories/genre_repository.dart';
import 'package:movie_roulette/data/repositories/movies_repository.dart';
import 'app.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => MovieRepository()),
        RepositoryProvider(create: (_) => GenreRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MovieBloc(context.read<MovieRepository>())),
          BlocProvider(create: (context) => GenreBloc(context.read<GenreRepository>())),
        ],
        child: App(),
      ),
    ),
  );
}
