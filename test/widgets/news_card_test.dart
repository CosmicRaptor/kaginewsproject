import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:kaginewsproject/l10n/l10n.dart';
import 'package:kaginewsproject/util/shimmer_effects.dart';
import 'package:kaginewsproject/widgets/news_card.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late NewsCluster testCluster;

  setUp(() {
    testCluster = NewsCluster(
      clusterNumber: 0,
      uniqueDomains: 1,
      numberOfTitles: 1,
      category: 'Science',
      title: 'Moon Base Alpha',
      shortSummary: 'Water discovered on the Moon!',
      didYouKnow: '',
      talkingPoints: [],
      quote: '',
      quoteAuthor: '',
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
  });

  testWidgets('NewsCard renders title, category, location', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: NewsCard(newsCluster: testCluster, category: "Test",)),
      ),
    );

    expect(find.text('Science'), findsOneWidget);
    expect(find.text('Moon Base Alpha'), findsOneWidget);
  });

  testWidgets('NewsCard renders shimmer image when image is provided', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: NewsCard(newsCluster: testCluster, category: "test",)),
      ),
    );

    expect(
      find.byType(Shimmer),
      findsOneWidget,
    ); // depends on how `imageShimmer` is implemented
  });
}
