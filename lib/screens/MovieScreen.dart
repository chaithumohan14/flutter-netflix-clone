import 'package:bloc_tuts/models/Movie.dart';
import 'package:bloc_tuts/providers/MoviesProvider.dart';
import 'package:bloc_tuts/utils/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;

  const MovieScreen({Key key, this.movie}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  TextStyle _whiteText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
  );

  TextStyle _whiteBoldText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        brightness: Brightness.dark,
        actions: [
          Consumer<MoviesProvider>(
            builder: (consumerContext, moviesProvider, consumerWidget) {
              int indexInState = moviesProvider.movies
                  .indexWhere((element) => element.id == widget.movie.id);
              if (indexInState < 0) {
                moviesProvider.addNewElement(widget.movie);
                indexInState = moviesProvider.movies
                    .indexWhere((element) => element.id == widget.movie.id);
              }
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(
                    moviesProvider.movies[indexInState].fav
                        ? Icons.favorite
                        : Icons.favorite_outline,
                  ),
                  onPressed: () {
                    moviesProvider.addedOrRemoveInFav(widget.movie);
                  },
                  splashRadius: 25,
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        child: ListView(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  child: CachedNetworkImage(
                    imageUrl: '$IMG_URL${widget.movie.thumbnail}',
                    fadeInDuration: Duration.zero,
                    cacheKey: widget.movie.thumbnail,
                  ),
                  decoration: BoxDecoration(
                    // borderRadius:
                    //     BorderRadius.vertical(bottom: Radius.circular(700)),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(
                        '$IMG_URL${widget.movie.thumbnail}',
                      ),
                    ),
                  ),
                ),
                Container(height: 275, color: Colors.transparent),
                Positioned(
                  bottom: -0,
                  left: MediaQuery.of(context).size.width / 2 - 25,
                  child: Container(
                    child: Center(
                      child: IconButton(
                        splashRadius: 30,
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.movie.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.25,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          widget.movie.rating.toString(),
                          style: _whiteBoldText,
                        ),
                      ),
                      Text(
                        "Rating",
                        style: _whiteText,
                      ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          widget.movie.date,
                          style: _whiteBoldText,
                        ),
                      ),
                      Text(
                        "Release Date",
                        style: _whiteText,
                      ),
                    ],
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.movie.overview,
                      style: _whiteText,
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
