import 'package:confere_desafio/bloc/product_bloc.dart';
import 'package:confere_desafio/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ProductBloc([]),
      child: AppWidget(),
    ),
  );
}
