import 'package:flutter/material.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.27);
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    // Listener
    this._pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 150) {
        this.siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      /* La diferencia entre PageView y PageView.builder, es que el primero
      * renderiza todos los elementos a la vez y puede generar un fallo de
      * memoria. Con PageView.builder se renderizan según se necesitan (bajo 
      * demanda).
      */
      child: PageView.builder(
        // children: _tarjetas(context),
        itemBuilder: (context, i) {
          return _tarjeta(context, peliculas[i]);
        },
        itemCount: this.peliculas.length,
        pageSnapping: false,
        controller: this._pageController,
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final tarjeta = Container(
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 110.0,
              ),
            ),
            Text(pelicula.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption)
          ],
        ));

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: tarjeta,
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return this.peliculas.map((pelicula) {
      return Container(
          margin: EdgeInsets.only(right: 10.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 110.0,
                ),
              ),
              Text(pelicula.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption)
            ],
          ));
    }).toList();
  }
}
