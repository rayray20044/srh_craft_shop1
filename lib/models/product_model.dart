class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? thumbnail;
  final String category;
  final List<String>? images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.thumbnail,
    required this.category,
    this.images,
  });

  // converts a json object into a product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"], //  productid from json
      name: json["name"] ?? "No Name", // default name if missing
      description: json["description"] ?? "No Description", // default description if missing
      price: json["price"] != null ? json["price"]["netPrice"].toDouble() : 0.0, // net price and converts to double

      //  thumbnail url
      thumbnail: json["images"] != null &&
          json["images"].isNotEmpty &&
          json["images"][0]["formats"] != null &&
          json["images"][0]["formats"]["thumbnail"] != null
          ? json["images"][0]["formats"]["thumbnail"]["url"]
          : null,

      // category name - unknown if missing
      category: json["category"] != null && json["category"].isNotEmpty
          ? json["category"][0]["name"]
          : "Unknown",

      // list of image urls
      images: json["images"] != null
          ? List<String>.from(json["images"].map((img) => img["url"]))
          : [],
    );
  }
}



