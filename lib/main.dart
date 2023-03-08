import 'package:flutter/material.dart';

void main() {
  runApp(const SearchImageDemo());
}

class SearchImageDemo extends StatelessWidget {
  const SearchImageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
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
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              //Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
