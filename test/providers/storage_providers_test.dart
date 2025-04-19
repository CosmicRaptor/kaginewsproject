import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kaginewsproject/models/categories_model.dart';
import 'package:kaginewsproject/providers/storage_providers.dart';
import 'package:kaginewsproject/default_subscribed_categories.dart';

// Mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
  });

  group('Storage Providers Tests', () {
    test(
      'sharedPreferencesProvider returns SharedPreferences instance',
      () async {
        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWith((ref) async => mockPrefs),
          ],
        );

        final prefs = await container.read(sharedPreferencesProvider.future);
        expect(prefs, mockPrefs);
      },
    );

    test(
      'getFirstTimeProvider returns true if firstTime key is missing',
      () async {
        when(() => mockPrefs.getBool('firstTime')).thenReturn(null);

        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWith((ref) async => mockPrefs),
          ],
        );

        final result = await container.read(getFirstTimeProvider.future);
        expect(result, true);
      },
    );

    test('getFirstTimeProvider returns false if already set', () async {
      when(() => mockPrefs.getBool('firstTime')).thenReturn(false);

      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWith((ref) async => mockPrefs),
        ],
      );

      final result = await container.read(getFirstTimeProvider.future);
      expect(result, false);
    });

    test(
      'getSavedCategoriesProvider initializes default categories if firstTime',
      () async {
        when(() => mockPrefs.getBool('firstTime')).thenReturn(null);
        when(
          () => mockPrefs.setBool('firstTime', false),
        ).thenAnswer((_) async => true);

        // No categories stored yet
        when(() => mockPrefs.getStringList('savedCategories')).thenReturn(null);
        when(
          () => mockPrefs.setStringList(any(), any()),
        ).thenAnswer((_) async => true);

        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWith((ref) async => mockPrefs),
          ],
        );

        final result = await container.read(getSavedCategoriesProvider.future);

        expect(result, defaultCategories);
        verify(() => mockPrefs.setBool('firstTime', false)).called(1);
      },
    );

    test(
      'getSavedCategoriesProvider returns decoded saved categories if not first time',
      () async {
        final testCategory = Category(name: "Test", file: "test.json");
        final encoded = jsonEncode(testCategory.toJson());

        when(() => mockPrefs.getBool('firstTime')).thenReturn(false);
        when(
          () => mockPrefs.getStringList('savedCategories'),
        ).thenReturn([encoded]);

        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWith((ref) async => mockPrefs),
          ],
        );

        final result = await container.read(getSavedCategoriesProvider.future);

        expect(result, isA<List<Category>>());
        expect(result.first.name, 'Test');
        expect(result.first.file, 'test.json');
      },
    );

    test(
      'saveCategoriesProvider stores encoded categories in SharedPreferences',
      () async {
        final testCategory = Category(name: "Test", file: "test.json");
        final expectedEncoded = [jsonEncode(testCategory.toJson())];

        when(
          () => mockPrefs.setStringList('savedCategories', expectedEncoded),
        ).thenAnswer((_) async => true);

        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWith((ref) async => mockPrefs),
          ],
        );

        await container.read(saveCategoriesProvider([testCategory]).future);

        verify(
          () => mockPrefs.setStringList('savedCategories', expectedEncoded),
        ).called(1);
      },
    );
  });
}
