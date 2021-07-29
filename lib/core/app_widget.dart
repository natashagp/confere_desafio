import 'package:confere_desafio/core/app_colors.dart';
import 'package:confere_desafio/src/pages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confere Desafio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.purple,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // home: TestPage(),
      home: ProductsPage(),
    );
  }
}
