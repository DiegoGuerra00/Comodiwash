import 'package:collection/collection.dart';
import 'package:comodiwash/models/cart_item.dart';
import 'package:flutter/material.dart';

class ShoppingCartRepository extends ChangeNotifier {
  List<CartItem> _cartList = [];

  UnmodifiableListView<CartItem> get cartList =>
      UnmodifiableListView(_cartList);

  save(CartItem cartItem) {
    // FIXME fix qtd handling
    /* _cartList.forEach((newitem) {
      if (!_cartList.contains(newitem)) {
        _cartList.add(newitem);
      } else {
        //TODO Increase qtd
      }
    }); */

    _cartList.add(cartItem);

    notifyListeners();
  }

  remove(CartItem item) {
    _cartList.remove(item);

    notifyListeners();
  }
}
