import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kaginewsproject/repository/news_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('NewsRepository', () {
    late MockHttpClient mockClient;
    late NewsRepository repository;

    setUp(() {
      mockClient = MockHttpClient();
      repository = NewsRepository(client: mockClient);
    });

    test('fetches categories successfully when response is 200', () async {
      when(
        () => mockClient.get(Uri.parse("https://kite.kagi.com/kite.json")),
      ).thenAnswer(
        (_) async => http.Response('{"timestamp": 0, "categories": []}', 200),
      );

      final result = await repository.getCategories();
      expect(result.categories, isEmpty);
    });

    test(
      'throws exception when fetching categories fails with non-200 status',
      () async {
        when(
          () => mockClient.get(Uri.parse("https://kite.kagi.com/kite.json")),
        ).thenAnswer((_) async => http.Response('Error', 404));

        expect(() => repository.getCategories(), throwsException);
      },
    );

    test('fetches category details successfully when response is 200', () async {
      when(
        () => mockClient.get(Uri.parse("https://kite.kagi.com/example.json")),
      ).thenAnswer(
        (_) async => http.Response(
          '{"category": "example", "timestamp": 0, "read": 0, "clusters": []}',
          200,
        ),
      );

      final result = await repository.getCategory("example.json");
      expect(result.clusters, isEmpty);
    });

    test(
      'throws exception when fetching category details fails with non-200 status',
      () async {
        when(
          () => mockClient.get(Uri.parse("https://kite.kagi.com/example.json")),
        ).thenAnswer((_) async => http.Response('Error', 404));

        expect(() => repository.getCategory("example.json"), throwsException);
      },
    );

    test(
      'fetches on this day data successfully when response is 200',
      () async {
        when(
          () =>
              mockClient.get(Uri.parse("https://kite.kagi.com/onthisday.json")),
        ).thenAnswer(
          (_) async => http.Response('{"timestamp": 0, "events": []}', 200),
        );

        final result = await repository.getOnThisDay();
        expect(result.events, isEmpty);
      },
    );

    test(
      'throws exception when fetching on this day data fails with non-200 status',
      () async {
        when(
          () =>
              mockClient.get(Uri.parse("https://kite.kagi.com/onthisday.json")),
        ).thenAnswer((_) async => http.Response('Error', 404));

        expect(() => repository.getOnThisDay(), throwsException);
      },
    );

    test(
      'fetches Wikipedia summary successfully when response is 200',
      () async {
        when(
          () => mockClient.get(
            Uri.parse(
              "https://en.wikipedia.org/api/rest_v1/page/summary/Example_Title",
            ),
          ),
        ).thenAnswer((_) async => http.Response('{"title": "Example"}', 200));

        final result = await repository.getWikipediaSummary("Example Title");
        expect(result.title, "Example");
      },
    );

    test(
      'throws exception when fetching Wikipedia summary fails with non-200 status',
      () async {
        when(
          () => mockClient.get(
            Uri.parse(
              "https://en.wikipedia.org/api/rest_v1/page/summary/Example_Title",
            ),
          ),
        ).thenAnswer((_) async => http.Response('Error', 404));

        expect(
          () => repository.getWikipediaSummary("Example Title"),
          throwsException,
        );
      },
    );
  });
}
