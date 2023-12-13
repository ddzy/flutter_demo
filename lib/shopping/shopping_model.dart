import 'package:flutter/material.dart';
class GoodsModel {
  const GoodsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.color,
  });

  final String id;
  final String name;
  final double price;
  final Color color;
}

class ShoppingProvider extends ChangeNotifier {
  final List<GoodsModel> _goods = [];

  List<GoodsModel> get goods => _goods;
  double get totalPrice =>
      goods.fold(0, (previousValue, element) => previousValue + element.price);

  void add(GoodsModel item) {
    _goods.add(item);
    notifyListeners();
  }

  void remove(String id) {
    _goods.removeWhere(
      (element) => element.id == id,
    );
    notifyListeners();
  }

  void clear() {
    _goods.clear();
    notifyListeners();
  }
}
