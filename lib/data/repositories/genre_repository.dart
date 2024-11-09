import 'package:movie_roulette/data/data_sources/genre_data_source.dart';
import 'package:movie_roulette/models/genre.dart';

class GenreRepository {
  final GenreDataSource _dataSource = GenreDataSource();

  Future<List<Genre>> getGenres() async {
    try {
      final response = await _dataSource.fetchGenres();
      return response.genres;
    } catch (e) {
      throw Exception('Erro ao obter gêneros: $e');
    }
  }
}
