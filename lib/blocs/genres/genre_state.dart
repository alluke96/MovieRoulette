import 'package:movie_roulette/models/genre.dart';

abstract class GenreState {}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final List<Genre> genres;

  GenreLoaded(this.genres);
}

class GenreError extends GenreState {
  final String message;

  GenreError(this.message);
}
