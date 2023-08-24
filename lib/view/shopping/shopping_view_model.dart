import 'package:freeshare/src/model/product.dart';
import 'package:freeshare/src/repository/product_repositoy.dart';
import 'package:freeshare/view/base_view_model.dart';
import 'package:flutter/material.dart';

class ShoppingViewModel extends BaseViewModel {
  List<Product> productList = [];
  final TextEditingController textController = TextEditingController();
  final ProductRepository productRepository = ProductRepository();

  String get keyword => textController.text.trim();

  Future<void> searchProductList() async {
    isBusy = true;
    final results = await Future.wait([
      productRepository.searchProductList(keyword),
      Future.delayed(const Duration(milliseconds: 555)),
    ]);
    productList = results[0];
    isBusy = false;
  }
}
