import 'package:confere_desafio/bloc/events/product_event.dart';
import 'package:confere_desafio/models/product_model.dart';

class AddProduct extends ProductEvent {
  late final ProductModel newProduct;

  AddProduct(ProductModel product) {
    newProduct = product;
  }
}
