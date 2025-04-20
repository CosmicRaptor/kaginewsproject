import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/widgets/sources_widget.dart';

void main() {
  testWidgets('SourcesWidget displays sources correctly', (
    WidgetTester tester,
  ) async {
    // Sample data
    final sources = [
      NewsDomains(name: "example", favicon: 'https://example.com/favicon1.png'),
      NewsDomains(
        name: "example2",
        favicon: 'https://example.com/favicon2.png',
      ),
    ];

    // Build the SourcesWidget
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: SourcesWidget(sources: sources))),
    );

    expect(find.byType(GridView), findsOneWidget);
    // Verify that the CachedNetworkImage is displayed for each source
    for (var source in sources) {
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is CachedNetworkImage && widget.imageUrl == source.favicon,
        ),
        findsOneWidget,
      );
    }
  });
}
