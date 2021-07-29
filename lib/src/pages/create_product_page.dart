import 'package:confere_desafio/bloc/events/add_product.dart';
import 'package:confere_desafio/bloc/product_bloc.dart';
import 'package:confere_desafio/core/core.dart';
import 'package:confere_desafio/database/database.dart';
import 'package:confere_desafio/models/product_model.dart';
import 'package:confere_desafio/src/components/product_custom_button_component.dart';
import 'package:confere_desafio/src/components/product_form_component.dart';
import 'package:confere_desafio/src/pages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController regularPriceController = TextEditingController();
  TextEditingController actualPriceController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();

  bool _onSale = false;

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
          'Criar Produto',
          style: TextStyle(color: AppColors.white),
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
                      value: _onSale,
                      onChanged: (bool newValue) {
                        setState(() {
                          _onSale = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    productCustomButtonComponent(
                        label: 'Criar Produto',
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            ProductModel newProduct = ProductModel(
                              name: nameController.text.toUpperCase(),
                              regularPrice: regularPriceController.text.isEmpty
                                  ? 0.0
                                  : double.parse(regularPriceController.text
                                      .replaceAll(',', '.')),
                              actualPrice: actualPriceController.text.isEmpty
                                  ? 0.0
                                  : double.parse(actualPriceController.text
                                      .replaceAll(',', '.')),
                              discountPercentage:
                                  discountPercentageController.text.isEmpty
                                      ? 0.0
                                      : double.parse(
                                          discountPercentageController.text
                                              .replaceAll(',', '.')),
                              onSale: _onSale,
                              image: 'Não possui',
                            );
                            db.insertProduct(newProduct).then(
                              (storedProduct) {
                                BlocProvider.of<ProductBloc>(context).add(
                                  AddProduct(storedProduct),
                                );
                              },
                            );
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
                                content:
                                    Text('Produto cadastrado com sucesso.'),
                              ),
                            );
                          }
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
}
