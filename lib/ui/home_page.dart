import 'package:flutter/material.dart';
import 'package:me_flix_flutter_app/services/services.dart';
import 'package:me_flix_flutter_app/widgets/movie_slider_card.dart';
import 'package:me_flix_flutter_app/pojo/movie_model.dart';
import 'package:me_flix_flutter_app/pojo/movie_response_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:me_flix_flutter_app/ui/movie_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Services _services = Services();
  List<Movie> upcomingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> nowPlayingMovies = [];

  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    getUpcomingMovies();
    getPopularMovies();
    getTopRatedMovies();
    getNowPlayingMovies();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void getUpcomingMovies() async {
    MovieResponse movieResponse = await _services.getMoviesOfType('upcoming');
    setState(() => upcomingMovies = movieResponse.getMovies);
  }

  void getPopularMovies() async {
    MovieResponse movieResponse = await _services.getMoviesOfType('popular');
    setState(() => popularMovies = movieResponse.getMovies);
  }

  void getTopRatedMovies() async {
    MovieResponse movieResponse = await _services.getMoviesOfType('top_rated');
    setState(() => topRatedMovies = movieResponse.getMovies);
  }

  void getNowPlayingMovies() async {
    MovieResponse movieResponse =
        await _services.getMoviesOfType('now_playing');
    setState(() => nowPlayingMovies = movieResponse.getMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MeFlix'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.42,
              child: upcomingMovies.isNotEmpty
                  ? PageView.builder(
                      controller: pageController,
                      itemCount: upcomingMovies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsPage(
                                    upcomingMovies[index].getId),
                              ),
                            );
                          },
                          child: MovieSliderCard(
                            moviePoster: upcomingMovies[index].getPosterPath,
                            movieTitle: upcomingMovies[index].getTitle,
                            movieRating: upcomingMovies[index].getRating,
                            movieDate: upcomingMovies[index].getReleasedate,
                            offset: pageOffset - index,
                          ),
                        );
                      },
                    )
                  : Container(
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.blueAccent,
                          size: 50,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Popular Movies'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'See More'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              child: popularMovies.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularMovies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsPage(
                                    popularMovies[index].getId),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            child: Card(
                              child: Image.network(
                                popularMovies[index].getPosterPath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.blueAccent,
                          size: 50,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Top Rated Movies'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'See More'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              child: topRatedMovies.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topRatedMovies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsPage(
                                    topRatedMovies[index].getId),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            child: Card(
                              child: Image.network(
                                topRatedMovies[index].getPosterPath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.blueAccent,
                          size: 50,
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Now Playing Movies'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'See More'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              child: nowPlayingMovies.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nowPlayingMovies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsPage(
                                    nowPlayingMovies[index].getId),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            child: Card(
                              child: Image.network(
                                nowPlayingMovies[index].getPosterPath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.blueAccent,
                          size: 50,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
