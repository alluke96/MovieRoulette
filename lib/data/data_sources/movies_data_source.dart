import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_roulette/models/movie.dart';

class MovieDataSource {
  final String apiToken = dotenv.env['API_TOKEN'] ?? '';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<MovieResponse> fetchPopularMovies({int page = 1}) async {
    final url = Uri.parse(
      '$baseUrl/discover/movie?include_adult=false&include_video=false&language=pt-BR&page=$page&sort_by=popularity.desc',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $apiToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return MovieResponse.fromJson(json);
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}
