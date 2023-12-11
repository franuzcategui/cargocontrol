class ProductModel{
  final List<String> productsNames;

  const ProductModel({
    required this.productsNames,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductModel &&
          runtimeType == other.runtimeType &&
          productsNames == other.productsNames);

  @override
  int get hashCode => productsNames.hashCode;

  @override
  String toString() {
    return 'ProductModel{' + ' productsNames: $productsNames,' + '}';
  }

  ProductModel copyWith({
    List<String>? productsNames,
  }) {
    return ProductModel(
      productsNames: productsNames ?? this.productsNames,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productsNames': this.productsNames,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productsNames: map['productsNames'] as List<String>,
    );
  }

}