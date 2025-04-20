import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/widgets/quote_text.dart';

void main() {
  testWidgets('QuoteText widget test', (WidgetTester tester) async {
    // Create a mock NewsCluster object
    final cluster = NewsCluster(
      clusterNumber: 0,
      uniqueDomains: 1,
      numberOfTitles: 1,
      category: 'Science',
      title: 'Moon Base Alpha',
      shortSummary: 'Water discovered on the Moon!',
      didYouKnow: '',
      talkingPoints: [],
      quote: 'Water is essential for life.',
      quoteAuthor: 'Dr. Jane Doe',
      quoteSourceUrl: '',
      quoteSourceDomain: '',
      location: 'Luna',
      perspectives: [],
      articles: [
        NewsArticle(
          title: 'Water discovered on the Moon!',
          image: 'https://example.com/image.jpg',
          imageCaption: 'An image of the Moon',
          link: 'https://example.com/article',
          domain: "example.com",
          date: DateTime(2023, 10, 1),
        ),
      ],
      domains: [],
      historicalBackground: '',
      humanitarianImpact: '',
      technicalDetails: [],
      businessAngleText: '',
      businessAnglePoints: [],
      internationalReactions: [],
      timeline: [],
      userActionItems: [],
    );

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: QuoteText(cluster: cluster))),
    );

    // Verify that the QuoteText widget displays the correct text
    expect(find.text(cluster.quote), findsOneWidget);
    expect(find.text('- ${cluster.quoteAuthor}'), findsOneWidget);
  });
}
