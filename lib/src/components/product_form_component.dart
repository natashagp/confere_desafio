import 'package:confere_desafio/core/core.dart';
import 'package:flutter/material.dart';

Widget productFormComponent({
  required GlobalKey<FormState> formKey,
  required TextEditingController nameController,
  required TextEditingController regularPriceController,
  required TextEditingController actualPriceController,
  required TextEditingController discountPercentageController,
  required Widget child,
}) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        _buildName(nameController: nameController),
        SizedBox(height: 20),
        _buildRegularPrice(regularPriceController: regularPriceController),
        SizedBox(height: 20),
        _buildActualPrice(actualPriceController: actualPriceController),
        SizedBox(height: 20),
        _buildDiscountPercentage(
            discountPercentageController: discountPercentageController),
        child
      ],
    ),
  );
}

Widget _buildName({required TextEditingController nameController}) {
  return TextFormField(
    controller: nameController,
    keyboardType: TextInputType.text,
    style: TextStyle(
      color: Colors.black,
      fontSize: 15,
    ),
    decoration: InputDecoration(
      labelText: "Nome",
      labelStyle: TextStyle(color: AppColors.purple),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.purple,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.purple),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.green),
      ),
      errorStyle: TextStyle(
        fontSize: 15,
        color: Colors.red,
        fontWeight: FontWeight.w400,
      ),
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    autofocus: false,
    validator: (value) {
      if (value!.isEmpty) {
        return "Informe o nome do produto";
      }
    },
  );
}

Widget _buildRegularPrice(
    {required TextEditingController regularPriceController}) {
  return TextFormField(
    controller: regularPriceController,
    keyboardType: TextInputType.number,
    style: TextStyle(
      color: Colors.black,
      fontSize: 15,
    ),
    decoration: InputDecoration(
      prefix: Text(
        'R\$ ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      labelText: "Preço",
      labelStyle: TextStyle(color: AppColors.purple),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.purple,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.purple),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.green),
      ),
      errorStyle: TextStyle(
        fontSize: 15,
        color: Colors.red,
        fontWeight: FontWeight.w400,
      ),
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value!.isEmpty) {
        return "Informe o preço do produto";
      }
    },
  );
}

Widget _buildActualPrice(
    {required TextEditingController actualPriceController}) {
  return TextFormField(
    controller: actualPriceController,
    keyboardType: TextInputType.number,
    style: TextStyle(
      color: Colors.black,
      fontSize: 15,
    ),
    decoration: InputDecoration(
      prefix: Text(
        'R\$ ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      labelText: "Preço de Promoção",
      labelStyle: TextStyle(color: AppColors.purple),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.purple,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.purple),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.green),
      ),
      errorStyle: TextStyle(
        fontSize: 15,
        color: Colors.red,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

Widget _buildDiscountPercentage(
    {required TextEditingController discountPercentageController}) {
  return TextFormField(
    controller: discountPercentageController,
    keyboardType: TextInputType.number,
    style: TextStyle(
      color: Colors.black,
      fontSize: 15,
    ),
    decoration: InputDecoration(
      suffix: Text(
        '%',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      labelText: "Percentual de Desconto",
      labelStyle: TextStyle(color: AppColors.purple),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.purple,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.purple),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.green),
      ),
      errorStyle: TextStyle(
        fontSize: 15,
        color: Colors.red,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
