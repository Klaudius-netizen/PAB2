import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String apiKey = '7347875a8052b695fd47aab9682244ab';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['results'] as List).cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/trending/movie/week?api_key=$apiKey"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['results'] as List).cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load trending movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load trending movies: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['results'] as List).cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load popular movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load popular movies: $e');
    }
  }

  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/search/movie?query=$query&api_key=$apiKey"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['results'] as List).cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to search movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }
}