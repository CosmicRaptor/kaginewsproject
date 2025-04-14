import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/models/onthisday_model.dart';
import 'package:kaginewsproject/models/wikipedia_summary_model.dart';
import '../models/categories_model.dart';

class NewsRepository {
  static Future<CategoryData> getCategories() async {
    final response = await http.get(
      Uri.parse("https://kite.kagi.com/kite.json"),
    );

    if (response.statusCode == 200) {
      // Decoding as UTF8 because of some emoji rendering issues.
      return CategoryData.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<NewsCategoryDetail> getCategory(String category) async {
    final response = await http.get(
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

  static Future<OnThisDay> getOnThisDay() async {
    final response = await http.get(
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

  static Future<WikiSummary> getWikipediaSummary(String title) async {
    // Wikipedia needs _ instead of spaces in the title.
    title = title.replaceAll(' ', '_');
    final response = await http.get(
      Uri.parse(
        'https://en.wikipedia.org/api/rest_v1/page/summary/${Uri.encodeQueryComponent(title)}',
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
