import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices{
  static const String apiKey = '7347875a8052b695fd47aab9682244ab';
  static const String baseUrl = 'https://api.themoviedb.org/';

  Future<List<Map<String, dynamic>>> getAllMovies() async{
    final response = await http.get(Uri.parse("$baseUrl/movie/now_plaaying?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getTrendingMovies() async{
    final response = await http.get(Uri.parse("$baseUrl/trending/movie/week?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getPopularMovies() async{
    final response = await http.get(Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
}