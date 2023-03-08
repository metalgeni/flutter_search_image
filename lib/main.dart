import 'package:flutter/material.dart';
import 'package:search_image/kakap_api.dart';
import 'package:search_image/pages/page_favorate.dart';
import 'package:search_image/pages/page_search.dart';

void main() {
  runApp(SearchImageDemo(api: KakaoApi()));
}

class SearchImageDemo extends StatelessWidget {
  final KakaoApi api;
  const SearchImageDemo({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.search), text: "검색"),
                Tab(icon: Icon(Icons.favorite), text: "즐겨찾기"),
              ],
            ),
            title: const Text('Image Search Demo'),
          ),
          body: TabBarView(
            children: [
              PageSearch(api: api),
              PageFavorate(),
            ],
          ),
        ),
      ),
    );
  }
}
