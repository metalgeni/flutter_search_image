import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class KakaoApi {
  final String baseUrl;
  final Map<String, SearchResult> cache;
  final http.Client client;

  KakaoApi({
    http.Client? client,
    Map<String, SearchResult>? cache,
    this.baseUrl = 'https://dapi.kakao.com/v2/search/image?query=',
  })  : client = client ?? http.Client(),
        cache = cache ?? <String, SearchResult>{};

  Future<SearchResult> search(String term) async {
    final cached = cache[term];
    if (cached != null) {
      return cached;
    } else {
      final result = await _fetchResults(term);

      cache[term] = result;

      return result;
    }
  }

  Future<SearchResult> _fetchResults(String term) async {
    final response = await client.get(
      Uri.parse('$baseUrl$term'),
      headers: {
        HttpHeaders.authorizationHeader:
            "KakaoAK 9fed88cc492adbc60ac4436abfc86a3b"
      },
    );
    final results = json.decode(response.body);

    return SearchResult.fromJson(results['documents']);
  }
}

class SearchResult {
  final List<SearchResultItem> items;

  SearchResult(this.items);

  factory SearchResult.fromJson(dynamic json) {
    final items = (json as List)
        .map((item) => SearchResultItem.fromJson(item))
        .toList(growable: false);

    return SearchResult(items);
  }

  bool get isPopulated => items.isNotEmpty;
  bool get isEmpty => items.isEmpty;
}

class SearchResultItem {
  final String display_sitename;
  final String image_url;

  SearchResultItem(this.display_sitename, this.image_url);

  factory SearchResultItem.fromJson(Map<String, dynamic> json) {
    return SearchResultItem(
        json['display_sitename'] as String, json['image_url'] as String);
  }
}
