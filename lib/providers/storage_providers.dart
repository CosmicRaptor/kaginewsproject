import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/models/categories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../default_subscribed_categories.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

final getFirstTimeProvider = FutureProvider<bool>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  // Check if the app is opened for the first time
  final firstTime = prefs.getBool('firstTime') ?? true;
  if (firstTime) {
    // If it's the first time, set it to false
    await prefs.setBool('firstTime', false);
  }
  return firstTime;
});

// Get the currently saved categories

final getSavedCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);

  // Check if the app is opened for the first time
  final firstTime = await ref.watch(getFirstTimeProvider.future);
  if (firstTime) {
    // Save default categories
    ref.watch(saveCategoriesProvider(defaultCategories));
    return defaultCategories;
  }
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
