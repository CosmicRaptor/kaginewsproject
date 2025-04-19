import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaginewsproject/default_subscribed_categories.dart';
import 'package:kaginewsproject/enums/event_type_enum.dart';
import 'package:kaginewsproject/providers/api_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kaginewsproject/models/categories_model.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/models/onthisday_model.dart';
import 'package:kaginewsproject/models/wikipedia_summary_model.dart';

import 'package:kaginewsproject/providers/storage_providers.dart';
import 'package:kaginewsproject/repository/news_repository.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockNewsRepository mockRepository;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockRepository = MockNewsRepository();
    mockPrefs = MockSharedPreferences();
  });

  group('News Providers Tests', () {
    test('categoriesProvider returns CategoryData', () async {
      final container = ProviderContainer(
        overrides: [
          newsRepositoryProvider.overrideWithValue(mockRepository),
          sharedPreferencesProvider.overrideWith((ref) async => mockPrefs),
        ],
      );

      final mockCategoryData = CategoryData(
        timestamp: 0000,
        categories: defaultCategories,
      );
      when(
        () => mockRepository.getCategories(mockPrefs),
      ).thenAnswer((_) async => mockCategoryData);

      final result = await container.read(categoriesProvider.future);

      expect(result, isA<CategoryData>());
      expect(result.categories, isA<List<Category>>());
    });

    test(
      'getCategoryProvider returns NewsCategoryDetail for a category',
      () async {
        final container = ProviderContainer(
          overrides: [
            newsRepositoryProvider.overrideWithValue(mockRepository),
            sharedPreferencesProvider.overrideWith((ref) async => mockPrefs),
          ],
        );

        const category = 'World';
        final mockDetail = NewsCategoryDetail(
          timestamp: 0000,
          read: 0,
          category: category,
          clusters: [],
        );

        when(
          () => mockRepository.getCategory(category, mockPrefs),
        ).thenAnswer((_) async => mockDetail);

        final result = await container.read(
          getCategoryProvider(category).future,
        );

        expect(result, isA<NewsCategoryDetail>());
        expect(result.category, category);
      },
    );

    test('getOnThisDayProvider returns OnThisDay', () async {
      final container = ProviderContainer(
        overrides: [
          newsRepositoryProvider.overrideWithValue(mockRepository),
          sharedPreferencesProvider.overrideWith((ref) async => mockPrefs),
        ],
      );

      final mockOnThisDay = OnThisDay(
        timestamp: 0000,
        events: [
          OnThisDayEvent(
            year: "2025",
            content: "Test",
            sortYear: 2025,
            type: EventType.event,
          ),
        ],
      );
      when(
        () => mockRepository.getOnThisDay(mockPrefs),
      ).thenAnswer((_) async => mockOnThisDay);

      final result = await container.read(getOnThisDayProvider.future);

      expect(result, isA<OnThisDay>());
      expect(result.events, isA<List<OnThisDayEvent>>());
    });

    test(
      'getWikipediaSummaryProvider returns WikiSummary for a title',
      () async {
        final container = ProviderContainer(
          overrides: [newsRepositoryProvider.overrideWithValue(mockRepository)],
        );

        const title = 'Flutter_(software)';
        final mockSummary = WikiSummary(title: title, extract: 'A UI toolkit.');

        when(
          () => mockRepository.getWikipediaSummary(title),
        ).thenAnswer((_) async => mockSummary);

        final result = await container.read(
          getWikipediaSummaryProvider(title).future,
        );

        expect(result, isA<WikiSummary>());
        expect(result.title, title);
      },
    );
  });
}
