import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roulette/roulette.dart';
import 'package:movie_roulette/blocs/movies/movie_bloc.dart';
import 'package:movie_roulette/blocs/movies/movie_event.dart';
import 'package:movie_roulette/blocs/movies/movie_state.dart';
import 'package:movie_roulette/models/movie.dart';

class RoulettePage extends StatefulWidget {
  const RoulettePage({super.key});

  @override
  State<RoulettePage> createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage> {
  static final _random = Random();

  final _controller = RouletteController();
  bool _clockwise = true;

  late RouletteGroup _group;
  late List<Movie> _movies;
  late List<ImageProvider> _movieImages;

  @override
  void initState() {
    super.initState();
    _movies = [];
    _movieImages = [];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roleta de Filmes"),
      ),
      body: BlocProvider(
        create: (context) => MovieBloc(context.read())..add(LoadMovies()), // Carregar filmes quando a página for exibida
        child: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieLoaded) {
              setState(() {
                _movies = state.movies;
                _movieImages = _movies.map((movie) {
                  return NetworkImage(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  );
                }).toList();
                _group = RouletteGroup.uniformImages(
                  _movieImages.length,
                  imageBuilder: (index) => _movieImages[index],
                  styleBuilder: (index) {
                    return const TextStyle(color: Colors.white);
                  },
                );
              });
            }
          },
          child: Center(
            child: _movieImages.isEmpty
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Roulette(
                            group: _group,
                            controller: _controller,
                            style: const RouletteStyle(
                              dividerThickness: 0.0,
                              dividerColor: Colors.black,
                              centerStickSizePercent: 0.05,
                              centerStickerColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final completed = await _controller.rollTo(
                            3,
                            clockwise: _clockwise,
                            offset: _random.nextDouble(),
                          );

                          if (completed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Animation completed')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Animation cancelled')),
                            );
                          }
                        },
                        child: const Text("Girar!"),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
