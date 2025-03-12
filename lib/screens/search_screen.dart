import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detail_screen.dart';
import 'package:pilem/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiServices _apiServices = ApiServices();
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];
  bool _isLoading = false; // Add a loading state

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchMovies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Debounced search
  void _searchMovies() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isLoading = true; // Start loading
    });

    // Wait for 500ms before making the request
    await Future.delayed(const Duration(milliseconds: 500));

final List<Map<String, dynamic>> searchJson = await _apiServices.searchMovies(_searchController.text);

final List<Movie> searchData = searchJson.map((json) => Movie.fromJson(json)).toList();

    setState(() {
      _searchResults = searchData;
      _isLoading = false; // Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search input field
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search movies...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _searchController.text.isNotEmpty,
                    child: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchResults.clear();
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Show loading indicator while searching
            if (_isLoading)
              const Center(child: CircularProgressIndicator(color: Colors.blue)),

            // Search results list

            Expanded(
              child: ListView.builder(
               itemCount: _searchResults.length,
               itemBuilder: (BuildContext context, int index) {
                final movie = _searchResults[index];
                return ListTile(
                  leading: CachedNetworkImage(
                  imageUrl: movie.posterPath != ''
                  ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
                  : 'https://placehold.co/50x75?text=No+Image', // Fallback URL
                  placeholder: (context, url) => CircularProgressIndicator(), // Loading indicator
                  errorWidget: (context, url, error) => Icon(Icons.error), // Error widget
                  width: 50, // Adjust width as needed
                  height: 75, // Adjust height as needed
                  fit: BoxFit.cover, // Adjust image fit
          ),
            title: Text(movie.title),
            onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(movie: movie),
                     ),
                   );
                 },
                );
              },
             ),
            ),
          ],
        ),
      ),
    );
  }
}
