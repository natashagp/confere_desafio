import 'package:confere_desafio/models/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  // Inicializando o banco de dados
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "productsDb.db"),
      version: 1,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE productsTable(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            onSale INTEGER,
            regularPrice REAL NOT NULL,
            actualPrice REAL,
            discountPercentage REAL,
            image TEXT
          )
        """);
      },
    );
  }

  // Deletando o banco de dados
  deleteDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "productsDb.db");
    await deleteDatabase(path);
  }

  // Metodo para Ler os Produtos
  Future<List<ProductModel>> getProducts() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> products = await db.query(
      "productsTable",
      // orderBy: 'name ASC',
    );
    return products.map((e) => ProductModel.fromMap(e)).toList();
  }

  // Metodo para Inserir Produto
  Future<ProductModel> insertProduct(ProductModel product) async {
    final Database db = await initDB();
    product.id = await db.insert("productsTable", product.toMap());
    return product;
  }

  // Metodo para Atualizar Produto
  Future<void> updateProduct(ProductModel product, int id) async {
    final Database db = await initDB();
    await db.update("productsTable", product.toMap(),
        where: "id=?", whereArgs: [id]);
  }

  // Metodo para Deletar Produto
  Future<void> deleteProduct(int id) async {
    final Database db = await initDB();
    await db.delete("productsTable", where: "id=?", whereArgs: [id]);
  }
}
