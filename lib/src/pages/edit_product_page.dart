import 'package:confere_desafio/core/core.dart';
import 'package:confere_desafio/database/database.dart';
import 'package:confere_desafio/models/product_model.dart';
import 'package:confere_desafio/providers/product_provider.dart';
import 'package:confere_desafio/src/components/product_custom_button_component.dart';
import 'package:confere_desafio/src/components/product_form_component.dart';
import 'package:confere_desafio/src/pages/products_page.dart';
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;

  EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController regularPriceController = TextEditingController();
  TextEditingController actualPriceController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();

  late bool onSale;

  late DB db;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.product.name;
    regularPriceController.text = widget.product.regularPrice.toString();
    actualPriceController.text = widget.product.actualPrice.toString();
    discountPercentageController.text =
        widget.product.discountPercentage.toString();
    setState(() {
      onSale = widget.product.onSale;
    });

    db = DB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Editar Produto',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: MediaQuery.of(context).size.height * 0.06,
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.all(28),
              child: productFormComponent(
                formKey: _formKey,
                nameController: nameController,
                regularPriceController: regularPriceController,
                actualPriceController: actualPriceController,
                discountPercentageController: discountPercentageController,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SwitchListTile(
                      activeColor: AppColors.purple,
                      title: Text("Disponível para Venda"),
                      value: onSale,
                      onChanged: (bool newValue) {
                        setState(() {
                          onSale = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    productCustomButtonComponent(
                        label: 'Editar',
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            ProductModel updatedProduct = widget.product;
                            updatedProduct.name =
                                nameController.text.toUpperCase();
                            updatedProduct.regularPrice = double.parse(
                                regularPriceController.text
                                    .replaceAll(',', '.'));
                            updatedProduct.actualPrice = double.parse(
                                actualPriceController.text
                                    .replaceAll(',', '.'));
                            updatedProduct.discountPercentage = double.parse(
                                discountPercentageController.text
                                    .replaceAll(',', '.'));
                            updatedProduct.onSale = onSale;
                            ProductProvider.updateProduct(
                                updatedProduct, updatedProduct.id!);

                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductsPage(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Produto editado com sucesso.'),
                              ),
                            );
                          }
                        }),
                    SizedBox(height: 20),
                    productCustomButtonComponent(
                        label: 'Excluir',
                        onPress: () {
                          showDeleteDialog();
                        }),
                  ],
                ),
              ),
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
