class ProductPage {
  List<Product> products;
  int total;
  int skip;
  int limit;

  ProductPage({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductPage.fromJson(Map<String, dynamic> json) {
    return ProductPage(
      products: (json['products'] as List).map((i) => Product.fromJson(i)).toList(),
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }
}

class Product {
  int id;
  String title;
  String description;
  String category;
  double price;
  int stock;
  double? discountPercentage;
  double? rating;
  List<String>? tags;
  String? brand;
  String? sku;
  double? weight;
  Dimensions? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<Review>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  Meta? meta;
  String? thumbnail;
  List<String>? images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.stock,
    this.discountPercentage,
    this.rating,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.thumbnail,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage']?.toDouble(),
      rating: json['rating']?.toDouble(),
      stock: json['stock'],
      tags: json.containsKey('tags') ? List<String>.from(json['tags']) : null,
      brand: json['brand'],
      sku: json['sku'],
      weight: json['weight']?.toDouble(),
      dimensions: json.containsKey('dimensions') ? Dimensions.fromJson(json['dimensions']) : null,
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      reviews: json.containsKey('reviews') ? (json['reviews'] as List).map((i) => Review.fromJson(i)).toList() : null,
      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'],
      meta: json.containsKey('meta') ? Meta.fromJson(json['meta']) : null,
      thumbnail: json['thumbnail'],
      images: json.containsKey('images') ? List<String>.from(json['images']) : null,
    );
  }
}

class Dimensions {
  double width;
  double height;
  double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      depth: json['depth'].toDouble(),
    );
  }
}

class Review {
  double rating;
  String comment;
  DateTime date;
  String reviewerName;
  String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'].toDouble(),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}

class Meta {
  DateTime createdAt;
  DateTime updatedAt;
  String barcode;
  String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      barcode: json['barcode'],
      qrCode: json['qrCode'],
    );
  }
}

