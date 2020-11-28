import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '4489918937d2c3cf6bbc599e0b57aaa7';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'languaje': _languaje});

    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    // print(decodedData['results']);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    // print(peliculas.items[1].originalTitle);

    return peliculas.items;
  }
}
