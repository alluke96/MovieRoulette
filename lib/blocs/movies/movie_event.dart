abstract class MovieEvent {}

class LoadMovies extends MovieEvent {
  final int page;

  LoadMovies({this.page = 1});
}
