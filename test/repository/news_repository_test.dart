import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kaginewsproject/repository/news_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('NewsRepository', () {
    late MockHttpClient mockClient;
    late MockSharedPreferences mockPrefs;
    late NewsRepository repository;

    setUp(() {
      mockClient = MockHttpClient();
      mockPrefs = MockSharedPreferences();
      repository = NewsRepository(client: mockClient);
      registerFallbackValue(Uri());
    });

    test('fetches categories successfully when response is 200', () async {
      when(() => mockPrefs.getString(any())).thenReturn(null);

      when(
        () => mockClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer(
        (_) async => http.Response.bytes(
          utf8.encode('{"timestamp": 0, "categories": []}'),
          200,
          headers: {'etag': 'etag123', 'last-modified': 'some-date'},
        ),
      );

      when(
        () => mockPrefs.setString(any(), any()),
      ).thenAnswer((_) async => true);

      final result = await repository.getCategories(mockPrefs);
      expect(result.categories, isEmpty);
    });

    test(
      'throws exception when fetching categories fails with non-200',
      () async {
        when(() => mockPrefs.getString(any())).thenReturn(null);

        when(
          () => mockClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response.bytes(utf8.encode('Error'), 404),
        );

        expect(() => repository.getCategories(mockPrefs), throwsException);
      },
    );

    test('fetches category details successfully when response is 200', () async {
      when(() => mockPrefs.getString(any())).thenReturn(null);

      when(
        () => mockClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer(
        (_) async => http.Response.bytes(
          utf8.encode(
            '{"category": "example", "timestamp": 0, "read": 0, "clusters": []}',
          ),
          200,
          headers: {'etag': 'etag456', 'last-modified': 'another-date'},
        ),
      );

      when(
        () => mockPrefs.setString(any(), any()),
      ).thenAnswer((_) async => true);

      final result = await repository.getCategory("example.json", mockPrefs);
      expect(result.clusters, isEmpty);
    });

    test('throws exception when fetching category details fails', () async {
      when(() => mockPrefs.getString(any())).thenReturn(null);

      when(
        () => mockClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response.bytes(utf8.encode('Error'), 404));

      expect(
        () => repository.getCategory("example.json", mockPrefs),
        throwsException,
      );
    });

    test(
      'fetches on this day data successfully when response is 200',
      () async {
        when(() => mockPrefs.getString(any())).thenReturn(null);

        when(
          () => mockClient.get(any(), headers: any(named: 'headers')),
        ).thenAnswer(
          (_) async => http.Response.bytes(
            utf8.encode('{"timestamp": 0, "events": []}'),
            200,
            headers: {
              'etag': 'etag-onthisday',
              'last-modified': 'date-onthisday',
            },
          ),
        );

        when(
          () => mockPrefs.setString(any(), any()),
        ).thenAnswer((_) async => true);

        final result = await repository.getOnThisDay(mockPrefs);
        expect(result.events, isEmpty);
      },
    );

    test('throws exception when fetching on this day fails', () async {
      when(() => mockPrefs.getString(any())).thenReturn(null);

      when(
        () => mockClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response.bytes(utf8.encode('Error'), 404));

      expect(() => repository.getOnThisDay(mockPrefs), throwsException);
    });

    test(
      'fetches Wikipedia summary successfully when response is 200',
      () async {
        when(() => mockClient.get(any())).thenAnswer(
          (_) async =>
              http.Response.bytes(utf8.encode('{"title": "Example"}'), 200),
        );

        final result = await repository.getWikipediaSummary("Example Title");
        expect(result.title, "Example");
      },
    );

    test('throws exception when Wikipedia summary fails', () async {
      when(
        () => mockClient.get(any()),
      ).thenAnswer((_) async => http.Response.bytes(utf8.encode('Error'), 404));

      expect(
        () => repository.getWikipediaSummary("Example Title"),
        throwsException,
      );
    });
  });
}
