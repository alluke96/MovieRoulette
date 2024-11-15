import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_roulette/blocs/movies/movie_event.dart';
import 'package:movie_roulette/blocs/movies/movie_state.dart';
import 'package:movie_roulette/data/repositories/movies_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<LoadMovies>(_onLoadMovies);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movieResponse = await movieRepository.getPopularMovies(page: event.page);
      emit(MovieLoaded(movieResponse));
    } catch (e) {
      emit(MovieError("Failed to load popular movies"));
    }
  }
}
