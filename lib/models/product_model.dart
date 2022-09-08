const String productId = "id";
const String productName = "name";
const String productCategory = "category";
const String productDescription = "description";
const String productSalePrice = "salePrice";
const String productFeatured = "featured";
const String productAvailable = "available";
const String productImageUrl = "imageUrl";
const String productStock = "stock";

class ProductModel {
  String? id;
  String? name;
  String? category;
  String? description;
  num salePrice;
  num stock;
  bool featured;
  bool available;
  String? imageUrl;

  ProductModel(
      {this.id,
      this.name,
      this.category,
      this.description,
      required this.salePrice,
      this.stock = 10,
      this.featured = true,
      this.available = true,
      this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      productId: id,
      productName: name,
      productCategory: category,
      productDescription: description,
      productSalePrice: salePrice,
      productStock: stock,
      productFeatured: featured,
      productAvailable: available,
      productImageUrl: imageUrl,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map[productId],
        name: map[productName],
        category: map[productCategory],
        description: map[productDescription],
        salePrice: map[productSalePrice],
        stock: map[productStock] ?? 10,
        featured: map[productFeatured],
        available: map[productAvailable],
        imageUrl: map[productImageUrl],
      );
}
