import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/models/categories_model.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/repository/news_repository.dart';

final categoriesProvider = FutureProvider<CategoryData>((ref) async {
  final response = await NewsRepository.getCategories();
  return response;
});

final getCategoryProvider = FutureProvider.family<NewsCategoryDetail, String>((
  ref,
  category,
) async {
  final response = await NewsRepository.getCategory(category);
  return response;
});
