import 'package:flutter/foundation.dart';

class FavorateModel extends ChangeNotifier {
  FavorateModel() {}

  final List<String> _favs = [];

  void add(String item) {
    _favs.add(item);
    notifyListeners();
  }

  void remove(String item) {
    _favs.remove(item);
    notifyListeners();
  }

  List<String> get favs => _favs;
}
