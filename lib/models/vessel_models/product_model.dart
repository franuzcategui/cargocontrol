class ProductModel{
  final String productsName;
  final String productId;
  final List<String> cosechaNames;
  final List<String> tipoNames;
  final List<String> varietyNames;

//<editor-fold desc="Data Methods">
  const ProductModel({
    required this.productsName,
    required this.productId,
    required this.cosechaNames,
    required this.tipoNames,
    required this.varietyNames,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductModel &&
          runtimeType == other.runtimeType &&
          productsName == other.productsName &&
          productId == other.productId &&
          cosechaNames == other.cosechaNames &&
          tipoNames == other.tipoNames &&
          varietyNames == other.varietyNames);

  @override
  int get hashCode =>
      productsName.hashCode ^
      productId.hashCode ^
      cosechaNames.hashCode ^
      tipoNames.hashCode ^
      varietyNames.hashCode;

  @override
  String toString() {
    return 'ProductModel{' +
        ' productsName: $productsName,' +
        ' productId: $productId,' +
        ' cosechaNames: $cosechaNames,' +
        ' tipoNames: $tipoNames,' +
        ' varietyNames: $varietyNames,' +
        '}';
  }

  ProductModel copyWith({
    String? productsName,
    String? productId,
    List<String>? cosechaNames,
    List<String>? originNames,
    List<String>? tipoNames,
    List<String>? varietyNames,
  }) {
    return ProductModel(
      productsName: productsName ?? this.productsName,
      productId: productId ?? this.productId,
      cosechaNames: cosechaNames ?? this.cosechaNames,
      tipoNames: tipoNames ?? this.tipoNames,
      varietyNames: varietyNames ?? this.varietyNames,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productsName': this.productsName,
      'productId': this.productId,
      'cosechaNames': this.cosechaNames.map((e) => e.toString()).toList(),
      'tipoNames': this.tipoNames.map((e) => e.toString()).toList(),
      'varietyNames': this.varietyNames.map((e) => e.toString()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productsName: map['productsName'] as String,
      productId: map['productId'] as String,
      cosechaNames: (map['cosechaNames'] as List<dynamic>).cast<String>(),
      tipoNames: (map['tipoNames'] as List<dynamic>).cast<String>(),
      varietyNames: (map['varietyNames'] as List<dynamic>).cast<String>(),
    );
  }

//</editor-fold>
}