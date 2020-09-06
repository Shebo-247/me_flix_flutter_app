import 'package:me_flix_flutter_app/pojo/movie_model.dart';

class MovieResponse{
  int page, totalPages, totalResults;
  List<Movie> movies;

  MovieResponse({this.page, this.totalPages, this.totalResults, this.movies});

  int get getPage => this.page;
  int get getTotalPages => this.totalPages;
  int get getTotalResults => this.totalResults;
  List<Movie> get getMovies => this.movies;
}