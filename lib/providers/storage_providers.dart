import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/models/categories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

// Get the currently saved categories

final getSavedCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  // Convert each from json to Category object
  final savedCategories = prefs.getStringList('savedCategories') ?? [];
  return savedCategories.map((category) {
    final Map<String, dynamic> json = Map<String, dynamic>.from(
      jsonDecode(category),
    );
    return Category.fromJson(json);
  }).toList();
});

// Save the categories to shared preferences

final saveCategoriesProvider = FutureProvider.family<void, List<Category>>((
  ref,
  categories,
) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  // Convert each Category object to json
  final List<String> jsonCategories =
      categories.map((category) {
        return jsonEncode(category.toJson());
      }).toList();
  await prefs.setStringList('savedCategories', jsonCategories);
});
