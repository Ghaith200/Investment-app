class CategoryResponse {
  final String status;
  final List<Category> categories;

  CategoryResponse({required this.status, required this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    var categoriesList = json['categories'] as List;
    List<Category> categories =
        categoriesList.map((i) => Category.fromJson(i)).toList();

    return CategoryResponse(
      status: json['status'],
      categories: categories,
    );
  }
}

class Category {
  final int id;
  final String name;
  final String description;
  final String? icon;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
