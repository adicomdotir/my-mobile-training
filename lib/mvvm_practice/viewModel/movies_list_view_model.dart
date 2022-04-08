import 'package:first_flutter/mvvm_practice/viewModel/movie_view_model.dart';
import 'package:first_flutter/mvvm_practice/webservice.dart';
import 'package:flutter/material.dart';

class MovieListViewModel extends ChangeNotifier {
  List<MovieViewModel> movies = [];
  Future<void> fetchMovies(String keyword) async {
    final results = await Webservice().fetchMovies(keyword);
    this.movies = results.map((item) => MovieViewModel(movie: item)).toList();
    notifyListeners();
  }
}
