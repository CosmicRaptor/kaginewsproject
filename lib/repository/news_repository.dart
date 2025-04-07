import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kaginewsproject/models/category_articles_stuff.dart';

import '../models/categories_model.dart';

class NewsRepository {
  Future<CategoryData> getCategories() async {
    final response = await http.get(Uri.parse("https://kite.kagi.com/kite.json"));

    if (response.statusCode == 200){
      return CategoryData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<NewsCategoryDetail> getCategory(String category) async {
    final response = await http.get(Uri.parse("https://kite.kagi.com/$category.json"));

    if (response.statusCode == 200){
      return NewsCategoryDetail.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load category');
    }
  }
}