import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/models/categories_model.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/models/onthisday_model.dart';
import 'package:kaginewsproject/repository/news_repository.dart';

import '../models/wikipedia_summary_model.dart';

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepository();
});

final categoriesProvider = FutureProvider<CategoryData>((ref) async {
  final repository = ref.watch(newsRepositoryProvider);
  final response = await repository.getCategories();
  return response;
});

final getCategoryProvider = FutureProvider.family<NewsCategoryDetail, String>((
  ref,
  category,
) async {
  final repository = ref.watch(newsRepositoryProvider);
  final response = await repository.getCategory(category);
  return response;
});

final getOnThisDayProvider = FutureProvider<OnThisDay>((ref) async {
  final repository = ref.watch(newsRepositoryProvider);
  final response = await repository.getOnThisDay();
  return response;
});

final getWikipediaSummaryProvider = FutureProvider.family<WikiSummary, String>((
  ref,
  title,
) async {
  final repository = ref.watch(newsRepositoryProvider);
  final response = await repository.getWikipediaSummary(title);
  return response;
});
