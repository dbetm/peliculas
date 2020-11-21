import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    // Personalizar dimesiones según el dispositivo
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //width: _screenSize.width * 0.7,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                "https://avatars0.githubusercontent.com/u/14257441?s=400&u=d2932b5749fd209f5334a712f7d202e249d7c5e6&v=4",
                fit: BoxFit.cover,
              ));
        },
        itemCount: this.peliculas.length,
        //pagination: new SwiperPagination(),
        // Pone los puntitos
        //control: new SwiperControl(),
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.4,
      ),
    );
  }
}
