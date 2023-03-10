import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:search_image/define/global_define.dart';

class FavorateModel extends ChangeNotifier {
  late Box<String> favoriteImageUrlBox;

  FavorateModel() {
    favoriteImageUrlBox = Hive.box(GlobalDefine.favoritesBox);
  }

  void add(String item) {
    favoriteImageUrlBox.put(item, '').whenComplete(() => notifyListeners());
  }

  void remove(String item) {
    favoriteImageUrlBox.delete(item).whenComplete(() => notifyListeners());
  }

  List<dynamic> get favs => favoriteImageUrlBox.keys.toList();

  bool isContain(String url) {
    return favoriteImageUrlBox.containsKey(url);
  }
}
