import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '4489918937d2c3cf6bbc599e0b57aaa7';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();
  // Tubería
  final _popularesStreamController =
      new StreamController<List<Pelicula>>.broadcast();

  // Insertar data al stream
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  // Recuperar data del stream
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStream() {
    this._popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarPeticion(Uri url) async {
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    // print(decodedData['results']);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    // print(peliculas.items[1].originalTitle);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'languaje': _languaje});

    return await this._procesarPeticion(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (this._cargando) return [];

    this._cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'languaje': _languaje,
      'page': _popularesPage.toString()
    });

    final respuestas = await this._procesarPeticion(url);

    this._populares.addAll(respuestas);
    popularesSink(this._populares);

    this._cargando = false;

    return respuestas;
  }
}
