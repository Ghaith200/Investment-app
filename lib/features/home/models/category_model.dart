class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String createdAt;
  final String updatedAt;
  final int? businessesCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.businessesCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      businessesCount: json['businesses_count'], // ممكن تكون null
    );
  }
}
