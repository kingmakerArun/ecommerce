import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final Map<Item, int> _cartItems = {};

  Map<Item, int> get cartItems => _cartItems;

  void addToCart(Item item, int quantity) {
    _cartItems[item] = (_cartItems[item] ?? 0) + quantity;
    notifyListeners();
  }

  void removeFromCart(Item item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  int getItemCount(Item item) {
    return _cartItems[item] ?? 0;
  }

  int get totalItems => _cartItems.values.fold(0, (sum, quantity) => sum + quantity);
}

class Item {
  final String title;
  final String price;
  final String imageUrl;

  Item(this.title, this.price, this.imageUrl);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Item) return false;
    return title == other.title && price == other.price && imageUrl == other.imageUrl;
  }

  @override
  int get hashCode => title.hashCode ^ price.hashCode ^ imageUrl.hashCode;
}
