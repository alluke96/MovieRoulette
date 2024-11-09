import 'package:flutter/material.dart';
import 'package:movie_roulette/view/pages/genre_page.dart';
import 'package:movie_roulette/view/pages/movies_page.dart';
import 'package:movie_roulette/view/pages/roulette_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roleta de Filmes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MovieListPage())),
            child: const Text('Filmes'),
          ),

          const SizedBox(height: 20),
          
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GenreListPage())),
            child: const Text('Gêneros'),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RoulettePage())),
            child: const Text('Roleta de Filmes'),
          ),
        ],
      ),
    );
  }
}
