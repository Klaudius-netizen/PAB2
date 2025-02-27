import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pilem/models/movie.dart';

class ApiServices{
  static const String apiKey = '7347875a8052b695fd47aab9682244ab';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> getAllMovies() async{
    final response = await http.get(Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return (data['results'] as List).map((e) => Movie.fromJson(e)).toList();
  }

  Future<List<Movie>> getTrendingMovies() async{
    final response = await http.get(Uri.parse("$baseUrl/trending/movie/week?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return (data['results'] as List).map((e) => Movie.fromJson(e)).toList();
  }

  Future<List<Movie>> getPopularMovies() async{
    final response = await http.get(Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return (data['results'] as List).map((e) => Movie.fromJson(e)).toList();
  }
}