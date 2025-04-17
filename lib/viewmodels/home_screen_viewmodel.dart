import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../models/categories_model.dart';
import '../providers/api_provider.dart';
import '../providers/storage_providers.dart';

class HomeViewModel extends ChangeNotifier {
  final Ref ref;
  final Set<int> _loadedTabs = {0};

  HomeViewModel(this.ref);

  Set<int> get loadedTabs => _loadedTabs;

  void markTabAsLoaded(int index) {
    _loadedTabs.add(index);
    notifyListeners();
  }

  AsyncValue<List<Category>> get categories =>
      ref.watch(getSavedCategoriesProvider);

  AsyncValue<Object> getCategoryData(int index, String fileName) {
    return fileName != "onthisday.json"
        ? ref.watch(getCategoryProvider(fileName))
        : ref.watch(getOnThisDayProvider);
  }
}
