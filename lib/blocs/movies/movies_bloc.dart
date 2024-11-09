
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_roulette/blocs/movies/movie_event.dart';
import 'package:movie_roulette/blocs/movies/movie_state.dart';
import 'package:movie_roulette/data/data_sources/movies_data_source.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieDataSource movieDataSource;

  MovieBloc(this.movieDataSource) : super(MovieInitial()) {
    on<LoadMovies>(_onLoadMovies);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movieResponse = await movieDataSource.fetchPopularMovies(page: event.page);
      emit(MovieLoaded(movieResponse.results));
    } catch (e) {
      emit(MovieError("Failed to load popular movies"));
    }
  }
}
