import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required Movie movie});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const SizedBox(
        width: 10,
      ),
      const Text("Rating",style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)
    );
  }
}