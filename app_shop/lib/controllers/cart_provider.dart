import 'package:app_shop/models/cart/get_products.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  // getCart() {
  //   final cartData = _cartBox.keys.map((key) {
  //     final item = _cartBox.get(key);
  //     return {
  //       "key": key,
  //       "id": item['id'],
  //       "name": item['name'],
  //       "price": item['price'],
  //       "qty": item['qty'],
  //       "category": item['category'],
  //       "imageUrl": item['imageUrl'],
  //       "sizes": item['sizes']
  //     };
  //   }).toList();
  //   _cart = cartData.reversed.toList();
  // }

  // Future<void> deleteCart(int key) async {
  //   await _cartBox.delete(key);
  // }

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter >= 1) {
      _counter--;
      notifyListeners();
    }
  }

  int? _productIndex;

  int get productIndex => _productIndex??0;

   set setProductIndex(int newState) {
    _productIndex = newState;
    notifyListeners();
  }

  List<Product> _checkout = [];

  List<Product> get checkout => _checkout;

  set setCheckoutList(List<Product> newState) {
    _checkout = newState;
    notifyListeners();
  }
}

