import 'package:dio/dio.dart';

const url = "https://raw.githubusercontent.com/natashagp/teste/master/db.json";

class API {
  static Future getProducts() async {
    try {
      return await Dio().get(url);
    } catch (e) {
      return e;
    }
  }
}
