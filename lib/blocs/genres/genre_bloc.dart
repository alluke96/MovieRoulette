import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_roulette/blocs/genres/genre_event.dart';
import 'package:movie_roulette/blocs/genres/genre_state.dart';
import 'package:movie_roulette/data/repositories/genre_repository.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GenreRepository genreRepository;

  GenreBloc(this.genreRepository) : super(GenreInitial()) {
    on<LoadGenres>(_onLoadGenres);
  }

  Future<void> _onLoadGenres(LoadGenres event, Emitter<GenreState> emit) async {
    emit(GenreLoading());
    try {
      final genres = await genreRepository.getGenres();
      emit(GenreLoaded(genres));
    } catch (e) {
      emit(GenreError('Erro ao carregar gêneros: $e'));
    }
  }
}
