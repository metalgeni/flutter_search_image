import 'package:flutter/foundation.dart';

class FavorateModel extends ChangeNotifier {
  FavorateModel() {}

  final List<String> _items = [];

  void add(String item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(String item) {
    _items.remove(item);
    notifyListeners();
  }
}


//search
/*
    var isInCart = context.select<CartModel, String>(
      // Here, we are only interested whether [item] is inside the cart.
      (cart) => cart.items.contains(item),
    );
    */


// favorate
//var cart = context.watch<CartModel>();
          // onPressed: () {
          //   cart.remove(cart.items[index]);
          // },
