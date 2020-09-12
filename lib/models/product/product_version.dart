const modelName = 'name';
const modelPrice = 'price';
const modelStock = 'stock';

class ProductVersion {
  ProductVersion({this.name, this.price, this.stock});

  ProductVersion.fromMap(Map<String, dynamic> map) {
    name = map[modelName] as String;
    price = map[modelPrice] as num;
    stock = map[modelStock] as int;
  }

  String name;
  num price;
  int stock;

  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'ProductVersion{name: $name, price: $price, stock: $stock}';
  }

  ProductVersion clone() {
    return ProductVersion(name: name, price: price, stock: stock);
  }
}
