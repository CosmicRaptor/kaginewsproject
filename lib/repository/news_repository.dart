import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/categories_model.dart';
import '../models/category_articles_stuff.dart';
import '../models/onthisday_model.dart';
import '../models/wikipedia_summary_model.dart';

class NewsRepository {
  final http.Client client;

  NewsRepository({http.Client? client}) : client = client ?? http.Client();

  Future<CategoryData> getCategories() async {
    final response = await client.get(
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

  Future<NewsCategoryDetail> getCategory(String category) async {
    final response = await client.get(
      Uri.parse("https://kite.kagi.com/$category"),
    );
    if (response.statusCode == 200) {
      return NewsCategoryDetail.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load category');
    }
  }

  Future<OnThisDay> getOnThisDay() async {
    final response = await client.get(
      Uri.parse("https://kite.kagi.com/onthisday.json"),
    );
    if (response.statusCode == 200) {
      return OnThisDay.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load on this day');
    }
  }

  Future<WikiSummary> getWikipediaSummary(String title) async {
    final encodedTitle = Uri.encodeQueryComponent(title.replaceAll(' ', '_'));
    final response = await client.get(
      Uri.parse(
        'https://en.wikipedia.org/api/rest_v1/page/summary/$encodedTitle',
      ),
    );
    if (response.statusCode == 200) {
      return WikiSummary.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load Wikipedia summary');
    }
  }
}
