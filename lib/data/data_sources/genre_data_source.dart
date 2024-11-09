import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_roulette/models/genre.dart';

class GenreDataSource {
  final String apiToken = dotenv.env['API_TOKEN'] ?? '';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<GenreResponse> fetchGenres() async {
    final apiToken = dotenv.env['API_TOKEN'];
    final url = Uri.parse('$baseUrl/genre/movie/list?language=pt-BR');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $apiToken',
        'accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GenreResponse.fromJson(data);
    } else {

      throw Exception('Erro ao buscar gêneros');
    }
  }
}
