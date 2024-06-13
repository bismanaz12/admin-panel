class productmodel {
  final double quantity;
  final double price;
  final String categoryName;
  final String id;
  final String title;
  final String url;
  final String description;

  productmodel({
    required this.quantity,
    required this.price,
    required this.categoryName,
    required this.id,
    required this.title,
    required this.url,
    required this.description,
  });

  factory productmodel.fromMap(Map<String, dynamic> json) {
    return productmodel(
      quantity: json['quantity']?.toDouble()?? 0.0,
      price: json['price']?.toDouble() ?? 0.0,
      categoryName: json['CategoryName'] ?? '',
      id: json['Id'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      description: json['Dis'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['quantity'] = quantity;
    data['price'] = price;
    data['CategoryName'] = categoryName;
    data['Id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['Dis'] = description;
    return data;
  }
}