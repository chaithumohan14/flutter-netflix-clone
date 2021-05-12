import 'package:bloc_tuts/models/Movie.dart';
import 'package:bloc_tuts/providers/AccountProvider.dart';
import 'package:bloc_tuts/screens/LoginScreen.dart';
import 'package:bloc_tuts/utils/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "package:dio/dio.dart";
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, accountProvider, consumerWidget) => SafeArea(
        child: FutureBuilder<String>(
          future: accountProvider.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(child: CircularProgressIndicator()));
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.isEmpty) {
                  return LoginScreen();
                } else {
                  return Scaffold(
                    drawer: Drawer(),
                    backgroundColor: Colors.black,
                    appBar: HomeScreenAppBar(),
                    body: ListView(
                      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                      children: [
                        HeroSlider(),
                        ...suffixes.keys
                            .map(
                              (e) => ListOfMovies(
                                url: e,
                                name: categories[
                                    suffixes.keys.toList().indexOf(e)],
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  );
                }
              } else {
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: Text(
                      "Something went wrong",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class HomeScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  final Size preferredSize;

  const HomeScreenAppBar({Key key})
      : this.preferredSize = const Size.fromHeight(70),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Container(
        height: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
            image: NetworkImage(
              'https://pngimg.com/uploads/netflix/netflix_PNG11.png',
            ),
          ),
        ),
      ),
      elevation: 0,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<AccountProvider>(context, listen: false).logOut();
            },
            splashRadius: 25,
          ),
        )
      ],
    );
  }
}

class HeroSlider extends StatefulWidget {
  @override
  _HeroSliderState createState() => _HeroSliderState();
}

class _HeroSliderState extends State<HeroSlider> {
  PageController _pageController = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 200,
          child: PageView.builder(
            onPageChanged: (newPage) {
              setState(() {
                _page = newPage;
              });
            },
            controller: _pageController,
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => Container(
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.only(left: 20, right: 15),
              child: CachedNetworkImage(
                fadeInDuration: Duration.zero,
                imageUrl: index % 2 == 0
                    ? 'https://image.tmdb.org/t/p/original/3kT4KvseaDOz3AbVZv1dIvpxEO3.jpg'
                    : "https://cms.qz.com/wp-content/uploads/2019/04/marvel-avengers-endgame-e1556039297104.jpg?quality=75&strip=all&w=1600&h=900&crop=1",
                fit: BoxFit.fill,
                cacheKey: index.toString(),
                imageBuilder: (imageContext, imageProvider) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  );
                },
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            itemCount: 5,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: (Iterable.generate(5))
                .toList()
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    Container(
                      height: 10,
                      width: 10,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: _page == key ? Colors.red : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        )
      ],
    );
  }
}

class ListOfMovies extends StatefulWidget {
  final String url;
  final String name;

  const ListOfMovies({Key key, this.url, this.name}) : super(key: key);

  @override
  _ListOfMoviesState createState() => _ListOfMoviesState();
}

class _ListOfMoviesState extends State<ListOfMovies> {
  Dio _dio = Dio();

  Future<List<Movie>> _getMovies() async {
    try {
      Response resp =
          await _dio.get<Map<String, dynamic>>('$URL${suffixes[widget.url]}');
      List<dynamic> body = resp.data['results'];
      List<Movie> movies = body
          .map(
            (e) => Movie.fromJson(e),
          )
          .toList();
      return movies;
    } catch (err) {
      print(err);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                widget.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 300,
            child: FutureBuilder<List<Movie>>(
              initialData: [],
              future: _getMovies(),
              builder: (context, snapshot) {
                return ListView.builder(
                    physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/movie',
                              arguments: snapshot.data[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: InkWell(
                            child: Container(
                              width: 170,
                              child: CachedNetworkImage(
                                fadeOutDuration: Duration.zero,
                                fadeInDuration: Duration.zero,
                                fadeInCurve: Curves.linear,
                                imageUrl:
                                    '$IMG_URL${snapshot.data[index].poster}',
                                imageBuilder: (imageContext, imageProvider) =>
                                    Container(
                                  width: 170,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    '$IMG_URL${snapshot.data[index].poster}',
                                  ),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
