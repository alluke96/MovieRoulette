import 'package:flutter/material.dart';
import 'package:movie_roulette/data/data_sources/movies_data_source.dart';
import 'package:movie_roulette/data/repositories/movies_repository.dart';
import 'package:movie_roulette/models/movie.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  late MovieRepository movieRepository;
  late Future<MovieResponse> moviesFuture;

  @override
  void initState() {
    super.initState();
    movieRepository = MovieRepository(MovieDataSource());
    moviesFuture = movieRepository.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Movies')),
      body: FutureBuilder<MovieResponse>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load movies'));
          } else {
            final movies = snapshot.data?.results ?? [];
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
