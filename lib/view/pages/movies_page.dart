import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_roulette/blocs/movies/movie_bloc.dart';
import 'package:movie_roulette/blocs/movies/movie_event.dart';
import 'package:movie_roulette/blocs/movies/movie_state.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes Populares'),
      ),
      body: BlocProvider(
        create: (context) => MovieBloc(context.read())..add(LoadMovies()), // Carrega os filmes quando a página for exibida
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MovieLoaded) {
              final movies = state.movies;

              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return ListTile(
                    leading: movie.posterPath != null
                        ? Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}')
                        : const Icon(Icons.movie),
                    title: Text(movie.title),
                    subtitle: Text(movie.releaseDate),
                    onTap: () {
                      // Navegar para a página de detalhes ou algo específico
                    },
                  );
                },
              );
            }

            if (state is MovieError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('Selecione um filme.'));
          },
        ),
      ),
    );
  }
}
