class Movie {
  int id;
  String title, posterPath, backdropPath, overview, releaseDate, rating, runtime;
  List<String> genres;

  Movie({
    this.id,
    this.title,
    this.posterPath,
    this.backdropPath,
    this.overview,
    this.releaseDate,
    this.rating,
    this.genres,
    this.runtime
  });

  int get getId => this.id;
  String get getTitle => this.title;
  String get getPosterPath => this.posterPath;
  String get getBackdropPath => this.backdropPath;
  String get getOverview => this.overview;
  String get getReleasedate => this.releaseDate;
  String get getRating => this.rating;
  String get getRuntime => this.runtime;
  List<String> get getGenres => this.genres;
}
