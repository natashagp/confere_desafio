import 'dart:convert';

import 'package:confere_desafio/api/api.dart';
import 'package:confere_desafio/database/database.dart';
import 'package:confere_desafio/models/product_model.dart';

class ProductApiProvider {
  static DB db = DB();
  static List<ProductModel> produtosJson = [];

  // Recuperar dados do arquivo Json do Github
  static Future getApiProducts() async {
    await API.getProducts().then(
      (response) {
        Iterable lista = json.decode(response.data);
        produtosJson =
            lista.map((model) => ProductModel.fromJson(model)).toList();
        for (int i = 0; i < produtosJson.length; i++) {
          db.insertProduct(produtosJson[i]);
        }
      },
    );
  }
}
