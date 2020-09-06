import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:me_flix_flutter_app/pojo/movie_response_model.dart';
import 'package:me_flix_flutter_app/pojo/movie_model.dart';
import 'package:me_flix_flutter_app/pojo/cast_model.dart';
import 'package:me_flix_flutter_app/pojo/trailer_model.dart';

class Services {
  static const String _apiKey = "8eba28c739e0632d1ebfe7fc585aafe6";
  static const String _baseUrl = "http://api.themoviedb.org/3";
  static const String _baseImageUrl = 'https://image.tmdb.org/t/p/w500/';

  Future<MovieResponse> getMoviesOfType(String type) async {
    http.Response response =
        await http.get('$_baseUrl/movie/$type?api_key=$_apiKey');
    var result = json.decode(response.body);
    List<Movie> movies = [];

    for (int i = 0; i < result['results'].length; i++) {
      movies.add(Movie(
        id: result['results'][i]['id'],
        title: result['results'][i]['title'],
        posterPath: '$_baseImageUrl${result['results'][i]['poster_path']}',
        backdropPath: '$_baseImageUrl${result['results'][i]['backdrop_path']}',
        overview: result['results'][i]['overview'],
        rating: result['results'][i]['vote_average'].toString(),
        releaseDate:
            (result['results'][i]['release_date']).toString().substring(0, 4),
      ));
    }

    MovieResponse movieResponse = MovieResponse(
        page: result['page'],
        totalPages: result['total_pages'],
        totalResults: result['total_results'],
        movies: movies);

    return movieResponse;
  }

  Future<Movie> getMovieDetails(int movieId) async {
    http.Response response =
        await http.get('$_baseUrl/movie/$movieId?api_key=$_apiKey');
    var result = json.decode(response.body);

    List<String> genres = [];
    var movieGenres = result['genres'];
    for (var i = 0; i < movieGenres.length; i++) {
      genres.add(movieGenres[i]['name']);
    }

    Movie movie = Movie(
      title: result['title'],
      posterPath: '$_baseImageUrl${result['poster_path']}',
      backdropPath: '$_baseImageUrl${result['backdrop_path']}',
      genres: genres,
      overview: result['overview'],
      releaseDate: result['release_date'].toString().substring(0, 4),
      runtime: result['runtime'].toString(),
      rating: result['vote_average'].toString(),
    );

    return movie;
  }

  Future getMovieCast(int movieId) async {
    http.Response response =
        await http.get('$_baseUrl/movie/$movieId/credits?api_key=$_apiKey');
    var result = json.decode(response.body);

    List<Cast> cast = [];

    for (var i = 0; i < result['cast'].length; i++) {
      cast.add(
        Cast(
          name: result['cast'][i]['name'],
          profilePath: result['cast'][i]['profile_path'] != null
              ? '$_baseImageUrl${result['cast'][i]['profile_path']}'
              : 'https://i0.wp.com/ahfirstaid.org/wp-content/uploads/2014/07/avatar-placeholder.png',
        ),
      );
    }
    return cast;
  }

  Future getMovieTrailers(int movieId) async{
    http.Response response =
        await http.get('$_baseUrl/movie/$movieId/videos?api_key=$_apiKey');
    var result = json.decode(response.body);

    List<Trailer> trailers = [];

    for (var i = 0; i < result['results'].length; i++){
      trailers.add(
        Trailer(
          key: result['results'][i]['key']
        ),
      );
    }
    return trailers;
  }

}
