import 'package:flutter/material.dart';
import 'package:movie_roulette/view/pages/genre_page.dart';
import 'package:movie_roulette/view/pages/movies_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
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
        title: Text('Roleta de Filmes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListPage())),
            child: Text('Filmes'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GenrePage())),
            child: Text('Gêneros de Filmes'),
          ),
        ],
      ),
    );
  }
}
