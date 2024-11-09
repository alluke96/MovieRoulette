import 'package:movie_roulette/data/data_sources/movies_data_source.dart';
import 'package:movie_roulette/models/movie.dart';

class MovieRepository {
  final MovieDataSource _movieDataSource = MovieDataSource();

  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      final movieResponse = await _movieDataSource.fetchPopularMovies(page: page);
      return movieResponse.results;
    } catch (e) {
      throw Exception('Erro ao obter filmes populares: $e');
    }
  }
}
