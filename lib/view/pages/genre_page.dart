import 'package:flutter/material.dart';
import 'package:movie_roulette/data/repositories/genre_repository.dart';
import 'package:movie_roulette/models/genre.dart';

class GenrePage extends StatefulWidget {
  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  final GenreRepository _genreRepository = GenreRepository();
  List<Genre> _genres = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGenres();
  }

  Future<void> _fetchGenres() async {
    try {
      final genres = await _genreRepository.getGenres();
      setState(() {
        _genres = genres;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Erro ao buscar gêneros: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gêneros de Filmes')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _genres.length,
              itemBuilder: (context, index) {
                final genre = _genres[index];
                return ListTile(
                  title: Text(genre.name),
                );
              },
            ),
    );
  }
}
