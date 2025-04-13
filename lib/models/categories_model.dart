class CategoryData {
  final int timestamp;
  final List<Category> categories;

  CategoryData({required this.timestamp, required this.categories});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      timestamp: json['timestamp'],
      categories:
          (json['categories'] as List)
              .map((item) => Category.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'categories': categories.map((item) => item.toJson()).toList(),
    };
  }
}

class Category {
  final String name;
  final String file;

  Category({required this.name, required this.file});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'], file: json['file']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'file': file};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Category) return false;
    return name == other.name && file == other.file;
  }

  @override
  int get hashCode => name.hashCode;
}
