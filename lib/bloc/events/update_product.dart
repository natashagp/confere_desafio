import 'package:confere_desafio/bloc/events/product_event.dart';
import 'package:confere_desafio/models/product_model.dart';

class UpdateProduct extends ProductEvent {
  late final ProductModel newProduct;
  late final int productIndex;

  UpdateProduct(int index, ProductModel product) {
    newProduct = product;
    productIndex = index;
  }
}
