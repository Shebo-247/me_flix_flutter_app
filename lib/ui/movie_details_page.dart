import 'dart:io';

import 'package:flutter/material.dart';
import 'package:me_flix_flutter_app/services/services.dart';
import 'package:me_flix_flutter_app/pojo/movie_model.dart';
import 'package:me_flix_flutter_app/pojo/cast_model.dart';
import 'package:me_flix_flutter_app/pojo/trailer_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  MovieDetailsPage(this.movieId);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Services _services = Services();

  Movie _currentMovie;
  List<Cast> _movieCast = [];
  List<Trailer> _movieTrailers = [];

  void getMovieData() async {
    Movie movie = await _services.getMovieDetails(widget.movieId);

    setState(() => _currentMovie = movie);
  }

  void getMovieCast() async {
    List<Cast> cast = await _services.getMovieCast(widget.movieId);

    setState(() => _movieCast = cast);
  }

  void getMovieTrailers() async {
    List<Trailer> trailers = await _services.getMovieTrailers(widget.movieId);

    setState(() => _movieTrailers = trailers);
  }

  String calculateRuntime(int minutes) {
    int hours = minutes ~/ 60;
    int reminder = minutes % 60;

    if (hours > 1) {
      return '$hours hours $reminder min';
    } else {
      return '$hours hour $reminder min';
    }
  }

  void launchURL(String key) async {
    if (Platform.isIOS) {
      if (await canLaunch('youtube://www.youtube.com/watch?v=$key')) {
        await launch('youtube://www.youtube.com/watch?v=$key',
            forceSafariVC: false);
      } else {
        if (await canLaunch('https://www.youtube.com/watch?v=$key')) {
          await launch('https://www.youtube.com/watch?v=$key');
        } else {
          throw 'Could not launch https://www.youtube.com/watch?v=$key';
        }
      }
    } else {
      String url = 'https://www.youtube.com/watch?v=$key';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  void initState() {
    super.initState();

    getMovieData();
    getMovieCast();
    getMovieTrailers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: _currentMovie != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(height: 325),
                        Container(
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            image: DecorationImage(
                              image:
                                  NetworkImage(_currentMovie.getBackdropPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back_ios, size: 35),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border, size: 35),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 225,
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * .85,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                topLeft: Radius.circular(50),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Icon(Icons.star,
                                            color: Colors.amber[300]),
                                        SizedBox(height: 10),
                                        Text(
                                          '${_currentMovie.getRating}/10',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Icon(Icons.access_time,
                                            color: Colors.amber[300]),
                                        SizedBox(height: 10),
                                        Text(
                                          calculateRuntime(int.parse(
                                              _currentMovie.getRuntime)),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Icon(Icons.public,
                                            color: Colors.amber[300]),
                                        SizedBox(height: 10),
                                        Text(
                                          _currentMovie.getReleasedate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10, bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        _currentMovie.getTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 20),
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _currentMovie.getGenres.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(_currentMovie.getGenres[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'Overview',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 30),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        _currentMovie.getOverview,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 20),
                      child: Text(
                        'Cast',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _movieCast.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        _movieCast[index].getProfilePath,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(_movieCast[index].getName,
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10, bottom: 20),
                      child: Text(
                        'Trailers',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _movieTrailers.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              launchURL(_movieTrailers[index].getKey);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 130,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://img.youtube.com/vi/${_movieTrailers[index].getKey}/0.jpg',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
