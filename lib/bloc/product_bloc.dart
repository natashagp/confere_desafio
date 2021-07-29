import 'package:confere_desafio/bloc/events/add_product.dart';
import 'package:confere_desafio/bloc/events/delete_product.dart';
import 'package:confere_desafio/bloc/events/get_products.dart';
import 'package:confere_desafio/bloc/events/product_event.dart';
import 'package:confere_desafio/bloc/events/update_product.dart';
import 'package:confere_desafio/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, List<ProductModel>> {
  ProductBloc(List<ProductModel> initialState) : super(initialState);

  @override
  Stream<List<ProductModel>> mapEventToState(ProductEvent event) async* {
    if (event is GetProducts) {
      yield event.productsList;
    } else if (event is AddProduct) {
      List<ProductModel> newState = List.from(state);
      newState.add(event.newProduct);
      yield newState;
    } else if (event is DeleteProduct) {
      List<ProductModel> newState = List.from(state);
      newState.removeAt(event.productIndex);
      yield newState;
    } else if (event is UpdateProduct) {
      List<ProductModel> newState = List.from(state);
      newState[event.productIndex] = event.newProduct;
      yield newState;
    }
  }
}
