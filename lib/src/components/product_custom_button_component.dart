import 'package:confere_desafio/core/core.dart';
import 'package:flutter/material.dart';

Widget productCustomButtonComponent(
    {required String label, required VoidCallback onPress}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.purple),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    ),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 17,
        ),
        textAlign: TextAlign.center,
      ),
    ),
    onPressed: onPress,
  );
}
