import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_roulette/blocs/genres/genre_bloc.dart';
import 'package:movie_roulette/blocs/genres/genre_event.dart';
import 'package:movie_roulette/blocs/genres/genre_state.dart';

class GenreListPage extends StatelessWidget {
  const GenreListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gêneros de Filmes'),
      ),
      body: BlocProvider(
        create: (context) => GenreBloc(context.read())..add(LoadGenres()), // Carrega os gêneros quando a página for exibida
        child: BlocBuilder<GenreBloc, GenreState>(
          builder: (context, state) {
            if (state is GenreLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GenreLoaded) {
              final genres = state.genres;

              return ListView.builder(
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  return ListTile(
                    title: Text(genre.name),
                    onTap: () {
                      // Você pode adicionar a navegação para uma lista de filmes filtrada por gênero aqui
                    },
                  );
                },
              );
            }

            if (state is GenreError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('Selecione um gênero.'));
          },
        ),
      ),
    );
  }
}
