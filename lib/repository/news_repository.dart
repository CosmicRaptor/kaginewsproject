import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/categories_model.dart';
import '../models/category_articles_stuff.dart';
import '../models/onthisday_model.dart';
import '../models/wikipedia_summary_model.dart';

class NewsRepository {
  final http.Client client;

  NewsRepository({http.Client? client}) : client = client ?? http.Client();

  Map<String, String> _buildHeadersForCache(String etag, String lastModified) {
    return {'If-None-Match': etag, 'If-Modified-Since': lastModified};
  }

  Future<CategoryData> getCategories(SharedPreferences prefs) async {
    final String? etag = prefs.getString('etag-categories');
    final String? lastModified = prefs.getString('lastModified-categories');
    Map<String, String> headers = {};
    if (etag != null && lastModified != null) {
      headers = _buildHeadersForCache(etag, lastModified);
    }

    final url = Uri.parse("https://kite.kagi.com/kite.json");

    try {
      final response = await client.get(url, headers: headers);
      final decodedBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        // Cache invalidated; update cache
        final headers = response.headers;
        prefs.setString('etag-categories', headers['etag'] ?? '');
        prefs.setString(
          'lastModified-categories',
          headers['last-modified'] ?? '',
        );
        prefs.setString('body-categories', decodedBody);

        return CategoryData.fromJson(
          jsonDecode(decodedBody) as Map<String, dynamic>,
        );
      } else if (response.statusCode == 304) {
        // Cache is still valid
        final cachedBody = prefs.getString('body-categories');
        if (cachedBody != null) {
          return CategoryData.fromJson(
            jsonDecode(cachedBody) as Map<String, dynamic>,
          );
        }
      }

      throw Exception('Failed to load categories');
    } catch (e) {
      final cachedBody = prefs.getString('body-categories');
      if (cachedBody != null) {
        return CategoryData.fromJson(
          jsonDecode(cachedBody) as Map<String, dynamic>,
        );
      } else {
        throw Exception('No internet and no cached categories available.');
      }
    }
  }

  Future<NewsCategoryDetail> getCategory(
    String category,
    SharedPreferences prefs,
  ) async {
    final String? etag = prefs.getString('etag-$category');
    final String? lastModified = prefs.getString('lastModified-$category');
    Map<String, String> headers = {};
    if (etag != null && lastModified != null) {
      headers = _buildHeadersForCache(etag, lastModified);
    }

    final url = Uri.parse("https://kite.kagi.com/$category");

    try {
      final response = await client.get(url, headers: headers);
      final decodedBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        final headers = response.headers;
        prefs.setString('etag-$category', headers['etag'] ?? '');
        prefs.setString(
          'lastModified-$category',
          headers['last-modified'] ?? '',
        );
        prefs.setString('body-$category', decodedBody);

        return NewsCategoryDetail.fromJson(
          jsonDecode(decodedBody) as Map<String, dynamic>,
        );
      } else if (response.statusCode == 304) {
        final cachedBody = prefs.getString('body-$category');
        if (cachedBody != null) {
          return NewsCategoryDetail.fromJson(
            jsonDecode(cachedBody) as Map<String, dynamic>,
          );
        }
      }

      throw Exception('Failed to load category');
    } catch (e) {
      final cachedBody = prefs.getString('body-$category');
      if (cachedBody != null) {
        return NewsCategoryDetail.fromJson(
          jsonDecode(cachedBody) as Map<String, dynamic>,
        );
      } else {
        throw Exception(
          'No internet and no cached data for $category available.',
        );
      }
    }
  }

  Future<OnThisDay> getOnThisDay(SharedPreferences prefs) async {
    try {
      final String? etag = prefs.getString('etag-onthisday');
      final String? lastModified = prefs.getString('lastModified-onthisday');
      Map<String, String> headers = {};
      if (etag != null && lastModified != null) {
        headers = _buildHeadersForCache(etag, lastModified);
      }

      final response = await client.get(
        Uri.parse("https://kite.kagi.com/onthisday.json"),
        headers: headers,
      );

      final decodedBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        final headers = response.headers;
        prefs.setString('etag-onthisday', headers['etag'] ?? '');
        prefs.setString(
          'lastModified-onthisday',
          headers['last-modified'] ?? '',
        );
        prefs.setString('body-onthisday', decodedBody);

        return OnThisDay.fromJson(
          jsonDecode(decodedBody) as Map<String, dynamic>,
        );
      } else if (response.statusCode == 304) {
        final cachedBody = prefs.getString('body-onthisday');
        if (cachedBody != null) {
          return OnThisDay.fromJson(
            jsonDecode(cachedBody) as Map<String, dynamic>,
          );
        } else {
          throw Exception('No cached data for on this day available.');
        }
      } else {
        throw Exception('Failed to load on this day');
      }
    } catch (e) {
      final cachedBody = prefs.getString('body-onthisday');
      if (cachedBody != null) {
        return OnThisDay.fromJson(
          jsonDecode(cachedBody) as Map<String, dynamic>,
        );
      } else {
        throw Exception(
          'No internet and no cached data for on this day available.',
        );
      }
    }
  }

  Future<WikiSummary> getWikipediaSummary(String title) async {
    final encodedTitle = Uri.encodeQueryComponent(title.replaceAll(' ', '_'));
    try {
      final response = await client.get(
        Uri.parse(
          'https://en.wikipedia.org/api/rest_v1/page/summary/$encodedTitle',
        ),
      );
      final decodedBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        return WikiSummary.fromJson(
          jsonDecode(decodedBody) as Map<String, dynamic>,
        );
      } else {
        throw Exception('Failed to load Wikipedia summary');
      }
    } catch (e) {
      throw Exception('Offline or failed to load Wikipedia summary');
    }
  }
}
