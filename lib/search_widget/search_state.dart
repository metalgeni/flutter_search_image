import 'package:search_image/model/kakap_api.dart';

class SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {}

class SearchNoTerm extends SearchState {}

class SearchPopulated extends SearchState {
  final SearchResult result;

  SearchPopulated(this.result);
}

class SearchEmpty extends SearchState {}
