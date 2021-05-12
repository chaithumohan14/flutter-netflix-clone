const String API_KEY = "4f2d540fb28b05b52c0443b24ff06b73";
const String URL = "http://api.themoviedb.org/3";
const String IMG_URL = "https://image.tmdb.org/t/p/original";
const Map<String, String> suffixes = {
  "trending": "/trending/all/week?api_key=$API_KEY&language=en-US",
  "originals": "/discover/tv?api_key=$API_KEY&with_networks=213",
  "topRated": "/movie/top_rated?api_key=$API_KEY&language=en-US,",
  "actionMovies": "/discover/movie?api_key=$API_KEY&with_genres=28",
  "comedyMovies": "/discover/movie?api_key=$API_KEY&with_genres=35",
  "horrorMovies": "/discover/movie?api_key=$API_KEY&with_genres=27",
  "romanceMovies": "/discover/movie?api_key=$API_KEY&with_genres=10749",
  "documenatary": "/discover/movie?api_key=$API_KEY&with_genres=99",
};

List<String> categories = [
  "Trending",
  "Originals",
  "Top Rated",
  "Action Movies",
  "Comedy Movies",
  "Horror Movies",
  "Romance Movies",
  "Documenatary",
];
