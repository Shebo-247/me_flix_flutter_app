import 'package:flutter/material.dart';

class MovieSliderCard extends StatelessWidget {
  final moviePoster, movieTitle, movieRating, movieDate;
  final double offset;

  MovieSliderCard(
      {this.moviePoster,
      this.movieTitle,
      this.movieRating,
      this.movieDate,
      this.offset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.network(
                moviePoster,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                movieTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.amber[300],
                      ),
                      SizedBox(width: 5),
                      Text(movieRating)
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(movieDate))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
