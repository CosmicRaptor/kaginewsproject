import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import '../models/categories_model.dart';

class NewsRepository {
  static Future<CategoryData> getCategories() async {
    final response = await http.get(
      Uri.parse("https://kite.kagi.com/kite.json"),
    );

    if (response.statusCode == 200) {
      return CategoryData.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<NewsCategoryDetail> getCategory(String category) async {
    final response = await http.get(
      Uri.parse("https://kite.kagi.com/$category.json"),
    );

    if (response.statusCode == 200) {
      return NewsCategoryDetail.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load category');
    }
  }
}
