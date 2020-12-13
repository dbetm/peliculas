import 'package:flutter/material.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Películas'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperTarjetas(), _footer(context)],
        )));
  }

  Widget _swiperTarjetas() {
    // this.peliculasProvider.getEnCines();

    // return CardSwiper(peliculas: [1, 2, 3, 4, 5]);
    return FutureBuilder(
      future: this.peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: 6.0),
          FutureBuilder(
              future: this.peliculasProvider.getPopulares(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                // snapshot.data?.forEach((p) => print(p.title));
                if (snapshot.hasData) {
                  return MovieHorizontal(peliculas: snapshot.data);
                }
                return Center(child: CircularProgressIndicator());
              })
        ]));
  }
}
