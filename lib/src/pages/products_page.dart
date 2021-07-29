import 'package:confere_desafio/bloc/events/get_products.dart';
import 'package:confere_desafio/bloc/product_bloc.dart';
import 'package:confere_desafio/core/core.dart';
import 'package:confere_desafio/database/database.dart';
import 'package:confere_desafio/providers/product_api_provider.dart';
import 'package:confere_desafio/models/product_model.dart';
import 'package:confere_desafio/src/pages/create_product_page.dart';
import 'package:confere_desafio/src/pages/details_page.dart';
import 'package:confere_desafio/src/pages/edit_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool fetching = true;

  DB db = DB();

  Future _checkExternalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _checked = (prefs.getBool('checked')) ?? false;

    if (_checked) {
      db.getProducts().then((productList) {
        BlocProvider.of<ProductBloc>(context).add(GetProducts(productList));
        setState(() {
          fetching = false;
        });
      });
    } else {
      prefs.setBool('checked', true);
      // Inserindo no banco de dados os valores do json
      await ProductApiProvider.getApiProducts().then((_) {
        db.getProducts().then((productList) {
          BlocProvider.of<ProductBloc>(context).add(GetProducts(productList));
          setState(() {
            fetching = false;
          });
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _checkExternalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produtos',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: fetching
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.purple,
              ),
            )
          : Container(
              padding: EdgeInsets.all(8),
              color: AppColors.lightGrey,
              child: BlocConsumer<ProductBloc, List<ProductModel>>(
                listener: (BuildContext context, productList) {},
                builder: (context, productList) {
                  productList.sort((a, b) => a.name.compareTo(b.name));
                  return ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModel product = productList[index];
                      return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsPage(product: product),
                              ),
                            );
                          },
                          leading: product.image != 'Não possui'
                              ? Image.network(
                                  product.image,
                                  height: 50,
                                  width: 50,
                                )
                              : Container(
                                  height: 50,
                                  width: 50,
                                  child: Icon(Icons.shopping_basket),
                                ),
                          title: Text(product.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Preço: R\$ ${product.regularPrice.toStringAsFixed(2).replaceAll('.', ',')}'),
                              product.actualPrice != product.regularPrice &&
                                      product.actualPrice != 0.0
                                  ? Text(
                                      'Preço de Promoção: R\$ ${product.actualPrice.toStringAsFixed(2).replaceAll('.', ',')}')
                                  : Container(),
                            ],
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: AppColors.purple,
                            radius: 17,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditProductPage(product: product),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: AppColors.white,
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateProductPage(),
            ),
          );
          // showAddDialog();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
