import 'package:confere_desafio/bloc/events/product_event.dart';

class DeleteProduct extends ProductEvent {
  late final int productIndex;

  DeleteProduct(int index) {
    productIndex = index;
  }
}
