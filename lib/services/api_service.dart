import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices{
  static const String apiKey = '7347875a8052b695fd47aab9682244ab';
  static const String baseUrl = '';

  Future<List<Map<String, dynamic>>> getAllMovies() async{
    final response = await http.get(Uri.parse("$baseUrl/movie/week?api_key=4apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
}