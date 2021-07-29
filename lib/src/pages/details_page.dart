import 'package:confere_desafio/core/core.dart';
import 'package:confere_desafio/database/database.dart';
import 'package:confere_desafio/models/product_model.dart';
import 'package:confere_desafio/providers/product_provider.dart';
import 'package:confere_desafio/src/pages/edit_product_page.dart';
import 'package:confere_desafio/src/pages/products_page.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final ProductModel product;

  DetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late DB db;

  @override
  void initState() {
    super.initState();
    db = DB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detalhes do Produto',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Container(
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.product.image != 'Não possui'
                    ? Center(
                        child: Image.network(
                          widget.product.image,
                        ),
                      )
                    : Center(
                        child: Container(
                          height: 200,
                          child: Icon(
                            Icons.shopping_basket,
                            color: AppColors.purple,
                            size: 80,
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Preço: R\$ ${widget.product.regularPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Preço de Promocao: R\$ ${widget.product.actualPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Desconto: ${widget.product.discountPercentage.toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Disponivel para Venda: ${widget.product.onSale == false ? 'Não' : 'Sim'}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.purple,
                      child: IconButton(
                        onPressed: () {
                          showDeleteDialog();
                        },
                        icon: Icon(Icons.delete),
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: 50),
                    CircleAvatar(
                      backgroundColor: AppColors.purple,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditProductPage(product: widget.product),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDeleteDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 150,
            child: Column(
              children: [
                SizedBox(height: 30),
                Text('Tem certeza que deseja excluir o produto?'),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.purple),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        ProductProvider.deleteProduct(widget.product.id!);
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductsPage(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Produto excluído com sucesso'),
                          ),
                        );
                      },
                      child: Text('Sim'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.purple),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Não'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
