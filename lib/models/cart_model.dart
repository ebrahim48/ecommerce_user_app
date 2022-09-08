const String cartProductId = "productId";
const String cartProductName = "productName";
const String cartProductImage = "productImage";
const String cartProductPrice = "productPrice";
const String cartProductQuantity = "productQuantity";
const String cartProductStock = "productStock";
const String cartProductCategory = "productCategory";

class CartModel {
  String? productId;
  String? productName;
  String? imageUrl;
  String? category;
  num salePrice;
  num quantity;
  num stock;

  CartModel({
    this.productId,
    this.productName,
    this.imageUrl,
    this.category,
    required this.salePrice,
    required this.stock,
     this.quantity=1,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      cartProductId: productId,
      cartProductName: productName,
      cartProductImage: imageUrl,
      cartProductCategory: category,
      cartProductPrice: salePrice,
      cartProductQuantity: quantity,
      cartProductStock: stock,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) => CartModel(
    productId: map[cartProductId],
    productName: map[cartProductName],
    imageUrl: map[cartProductImage],
    category: map[cartProductCategory],
    salePrice: map[cartProductPrice],
    quantity: map[cartProductQuantity],
    stock: map[cartProductStock],
      );
}
