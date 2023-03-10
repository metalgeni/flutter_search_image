import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:search_image/define/global_define.dart';

import 'package:search_image/model/kakap_api.dart';
import 'package:search_image/model/favorate.dart';
import 'package:search_image/pages/page_favorate.dart';
import 'package:search_image/pages/page_search.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(GlobalDefine.favoritesBox);

  runApp(SearchImageDemo(api: KakaoApi()));
}

class SearchImageDemo extends StatelessWidget {
  final KakaoApi api;
  const SearchImageDemo({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavorateModel()),
        ],
        child: MaterialApp(
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                bottom: const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.search), text: GlobalDefine.search),
                    Tab(
                        icon: Icon(Icons.favorite),
                        text: GlobalDefine.favorate),
                  ],
                ),
                title: const Text('Image Search Demo'),
              ),
              body: TabBarView(
                children: [
                  PageSearch(api: api),
                  const PageFavorate(),
                ],
              ),
            ),
          ),
        ));
  }
}
