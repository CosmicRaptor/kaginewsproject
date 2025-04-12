import 'package:flutter/material.dart';
import 'package:kaginewsproject/l10n/l10n.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/util/scroll_haptics.dart';
import 'package:kaginewsproject/widgets/general_purpose_card.dart';
import 'package:kaginewsproject/widgets/news_image_with_caption.dart';

import '../widgets/bullet_point.dart';
import '../widgets/dashed_line_divider.dart';

class NewsScreen extends StatelessWidget {
  final NewsCluster cluster;
  const NewsScreen({super.key, required this.cluster});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.news, style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: haptics,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  cluster.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Short summary
                Text(
                  cluster.shortSummary,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),

                // Location
                if (cluster.location.isNotEmpty)
                  Row(
                    children: [
                      // Location icon
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      Text(
                        cluster.location,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),

                // Primary Image
                if (cluster.articles[0].image.isNotEmpty)
                  NewsImageWithCaption(article: cluster.articles[0]),
                const SizedBox(height: 30),

                // Highlights heading
                Text(
                  l10n.highlights,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomPaint(painter: DashedLineDivider()),
                ),
                const SizedBox(height: 16),

                // Talking points(highlights)
                ...cluster.talkingPoints.map((highlight) {
                  final highlightList = highlight.split(':');
                  final title = highlightList[0];
                  final content =
                      highlightList.length > 1 ? highlightList[1] : "";

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BulletPoint(
                          text: title.trim(),
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          bulletSize: 8,
                          bulletColor: Theme.of(context).colorScheme.primary,
                          spacing: 8,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          content.trim(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: CustomPaint(painter: DashedLineDivider()),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),

                // Quote card
                SizedBox(
                  width: double.infinity,
                  child: GeneralPurposeCard(
                    title: cluster.quote,
                    description: cluster.quoteAuthor,
                    url: cluster.quoteSourceUrl,
                    urlDomain: cluster.quoteSourceDomain,
                  ),
                ),
                const SizedBox(height: 16),

                // Optional second image
                if (cluster.articles.length > 1 &&
                    cluster.articles[1].image.isNotEmpty)
                  NewsImageWithCaption(article: cluster.articles[1]),

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 16),

                // Perspectives heading
                if (cluster.perspectives.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.perspectives,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: IntrinsicHeight(
                          child: Row(
                            children:
                                cluster.perspectives.map((perspective) {
                                  final perspectiveArray = perspective.text
                                      .split(":");
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: SizedBox(
                                      width: 300,
                                      // height: 300,
                                      child: GeneralPurposeCard(
                                        title: perspectiveArray[0],
                                        description: perspectiveArray[1],
                                        url: perspective.sources[0].url,
                                        urlDomain: perspective.sources[0].name,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 16),

                // Historical background
                if (cluster.historicalBackground.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.historicalBackground,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        cluster.historicalBackground,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),

                const SizedBox(height: 16),

                // Humanitarian impact
                if (cluster.humanitarianImpact.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.humanitarianImpact,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        cluster.humanitarianImpact,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),

                const SizedBox(height: 16),

                // Technical details
                if (cluster.technicalDetails.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.technicalDetails,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...cluster.technicalDetails.map((techDetail) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BulletPoint(
                                text: techDetail.trim(),
                                style: Theme.of(context).textTheme.bodyLarge,
                                bulletSize: 8,
                                bulletColor:
                                    Theme.of(context).colorScheme.primary,
                                spacing: 8,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),

                // Business angle
                if (cluster.businessAngleText.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.businessAngle,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        cluster.businessAngleText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),

                // Business angle points
                if (cluster.businessAnglePoints.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.businessAngle,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...cluster.businessAnglePoints.map((businessAngle) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BulletPoint(
                                text: businessAngle.trim(),
                                style: Theme.of(context).textTheme.bodyLarge,
                                bulletSize: 8,
                                bulletColor:
                                    Theme.of(context).colorScheme.primary,
                                spacing: 8,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),

                // International reactions
                if (cluster.internationalReactions.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.internationalReactions,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...cluster.internationalReactions.map((reaction) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BulletPoint(
                                text: reaction.trim(),
                                style: Theme.of(context).textTheme.bodyLarge,
                                bulletSize: 8,
                                bulletColor:
                                    Theme.of(context).colorScheme.primary,
                                spacing: 8,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
