enum ProductType {
  classic,
  modern,
}

extension ProductTypeParser on ProductType {
  bool get isClassic => this == ProductType.classic;
  bool get isModern => this == ProductType.modern;
  static ProductType fromName(String? name,
      [ProductType value = ProductType.modern]) {
    if (name == null) return value;
    try {
      return ProductType.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}
