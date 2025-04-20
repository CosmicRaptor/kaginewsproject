import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/widgets/news_image_with_caption.dart';

void main() {
  testWidgets('NewsImageWithCaption widget test', (WidgetTester tester) async {
    // Create a mock NewsArticle object
    final article = NewsArticle(
      image: 'https://example.com/image.jpg',
      imageCaption: 'This is a caption',
      title: 'Test Title',
      link: "https://example.com",
      domain: "example.com",
      date: DateTime.now(),
    );

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NewsImageWithCaption(
            key: const Key('news_image_with_caption'),
            article: article,
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('news_image_with_caption')), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text(article.imageCaption), findsOneWidget);
  });
}
