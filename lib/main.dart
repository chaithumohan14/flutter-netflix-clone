import 'package:bloc_tuts/models/Movie.dart';
import 'package:bloc_tuts/providers/AccountProvider.dart';
import 'package:bloc_tuts/providers/MoviesProvider.dart';
import 'package:bloc_tuts/screens/HomeScreen.dart';
import 'package:bloc_tuts/screens/MovieScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => HomeScreen());
            case '/movie':
              Movie movie = settings.arguments as Movie;
              return MaterialPageRoute(
                builder: (_) => MovieScreen(
                  movie: movie,
                ),
              );
            default:
              return MaterialPageRoute(builder: (_) => HomeScreen());
          }
        },
      ),
    );
  }
}
