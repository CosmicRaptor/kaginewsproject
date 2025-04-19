import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/viewmodels/home_screen_viewmodel.dart';
import 'package:mocktail/mocktail.dart';

import 'package:kaginewsproject/models/categories_model.dart';
import 'package:kaginewsproject/providers/storage_providers.dart';

// Mock for Ref
class MockRef extends Mock implements Ref {}

void main() {
  group('HomeViewModel Tests', () {
    late MockRef mockRef;
    late HomeViewModel viewModel;

    setUp(() {
      mockRef = MockRef();
      viewModel = HomeViewModel(mockRef);
    });

    test('initially tab 0 is loaded', () {
      expect(viewModel.loadedTabs.contains(0), isTrue);
    });

    test('markTabAsLoaded adds index and notifies listeners', () {
      final notified = <bool>[];
      viewModel.addListener(() => notified.add(true));

      viewModel.markTabAsLoaded(1);

      expect(viewModel.loadedTabs.contains(1), isTrue);
      expect(notified.isNotEmpty, isTrue);
    });

    test('categories returns saved categories from provider', () {
      final fakeCategories = AsyncValue.data([
        Category(name: "Test", file: "test.json"),
      ]);

      when(
        () => mockRef.watch(getSavedCategoriesProvider),
      ).thenReturn(fakeCategories);

      final result = viewModel.categories;

      expect(result, fakeCategories);
    });
  });
}
