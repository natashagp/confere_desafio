import 'package:confere_desafio/database/database.dart';
import 'package:confere_desafio/models/product_model.dart';

class ProductProvider {
  static DB db = DB();

  // Adicionar produto
  static addProduct(ProductModel product) {
    db.insertProduct(product);
  }

  // Atualizar produto
  static updateProduct(ProductModel product, int id) {
    db.updateProduct(product, id);
  }

  // Deletar produto
  static deleteProduct(int id) {
    db.deleteProduct(id);
  }

  // Ler produtos
  static getProducts() {
    db.getProducts();
  }
}
