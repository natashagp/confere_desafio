class ProductModel {
  int? id;
  String name;
  bool onSale;
  double regularPrice;
  double actualPrice;
  double discountPercentage;
  String image;

  ProductModel({
    this.id,
    required this.name,
    required this.onSale,
    required this.regularPrice,
    required this.actualPrice,
    required this.discountPercentage,
    required this.image,
  });

  // Metodos do banco de dados
  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        onSale: json["onSale"] == 1,
        regularPrice: json["regularPrice"],
        actualPrice: json["actualPrice"],
        discountPercentage: json["discountPercentage"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "name": name,
      "onSale": onSale ? 1 : 0,
      "regularPrice": regularPrice,
      "actualPrice": actualPrice,
      "discountPercentage": discountPercentage,
      "image": image,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  // Metodos do arquivo json
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        onSale: json["on_sale"],
        regularPrice: double.parse(
          json["regular_price"].replaceAll(',', '.').replaceAll('R\$ ', ''),
        ),
        actualPrice: double.parse(
          json["actual_price"].replaceAll(',', '.').replaceAll('R\$ ', ''),
        ),
        discountPercentage: double.parse(
          json["discount_percentage"].replaceAll('%', '').replaceAll('', '0'),
        ),
        image: json["image"] == '' ? 'Não possui' : json["image"],
      );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "onSale": onSale,
      "regularPrice": regularPrice,
      "actualPrice": actualPrice,
      "discountPercentage": discountPercentage,
      "image": image,
    };
  }
}
