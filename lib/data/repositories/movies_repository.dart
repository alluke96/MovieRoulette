import 'package:movie_roulette/data/data_sources/movies_data_source.dart';
import 'package:movie_roulette/models/movie.dart';

class MovieRepository {
  final MovieDataSource dataSource;

  MovieRepository(this.dataSource);

  Future<MovieResponse> getPopularMovies({int page = 1}) {
    return dataSource.fetchPopularMovies(page: page);
  }
}
