import 'package:confere_desafio/bloc/events/product_event.dart';
import 'package:confere_desafio/models/product_model.dart';

class GetProducts extends ProductEvent {
  late final List<ProductModel> productsList;

  GetProducts(List<ProductModel> products) {
    productsList = products;
  }
}
