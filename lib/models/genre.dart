class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

class GenreResponse {
  final List<Genre> genres;

  GenreResponse({required this.genres});

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    var genresJson = json['genres'] as List;
    List<Genre> genresList = genresJson.map((genre) => Genre.fromJson(genre)).toList();

    return GenreResponse(genres: genresList);
  }
}
