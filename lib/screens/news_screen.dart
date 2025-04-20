import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/providers/viewmodel_providers.dart';

import '../l10n/l10n.dart';
import '../models/category_articles_stuff.dart';
import '../util/scroll_haptics.dart';
import '../widgets/general_purpose_card.dart';
import '../widgets/news_image_with_caption.dart';
import '../widgets/timeline_stepper.dart';
import '../widgets/bullet_point.dart';
import '../widgets/dashed_line_divider.dart';
import '../widgets/sources_widget.dart';

class NewsScreen extends ConsumerWidget {
  final NewsCluster cluster;
  final String category;
  const NewsScreen({super.key, required this.cluster, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final vm = ref.watch(newsVMProvider(cluster));
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
            child: SelectionArea(
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
                  // const SizedBox(height: 10),

                  // Location
                  if (cluster.location.isNotEmpty)
                    Column(
                      children: [
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
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    iconSize: 20,
                                    onPressed: () {
                                      vm.shareArticle(category);
                                    },
                                    tooltip: 'Share',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 24),
                      ],
                    ),

                  // Primary Image
                  if (cluster.articles[0].image.isNotEmpty)
                    Column(
                      children: [
                        NewsImageWithCaption(article: cluster.articles[0]),
                        const SizedBox(height: 30),
                      ],
                    ),

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
                  if (cluster.quote.isNotEmpty &&
                      cluster.quoteAuthor.isNotEmpty)
                    Column(
                      children: [
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
                      ],
                    ),

                  // Optional second image
                  if (cluster.articles.length > 1 &&
                      cluster.articles[1].image.isNotEmpty)
                    Column(
                      children: [
                        NewsImageWithCaption(article: cluster.articles[1]),
                        const SizedBox(height: 30),
                        const Divider(),
                        const SizedBox(height: 16),
                      ],
                    ),

                  // Perspectives
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
                                          urlDomain:
                                              perspective.sources[0].name,
                                          textStyle:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyLarge,
                                          titleStyle: Theme.of(
                                            context,
                                          ).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

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
                        const SizedBox(height: 16),
                      ],
                    ),

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
                        const SizedBox(height: 16),
                      ],
                    ),

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
                                // const Divider(),
                                // const SizedBox(height: 16),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),

                  // Timeline
                  if (cluster.timeline.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        const SizedBox(height: 16),
                        Text(
                          l10n.timeline,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TimelineStepper(timeline: cluster.timeline),
                        const Divider(),
                      ],
                    ),

                  // Sources
                  if (cluster.domains.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.sources,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: SourcesWidget(sources: cluster.domains),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                  // Did you know
                  if (cluster.didYouKnow.isNotEmpty)
                    Column(
                      children: [
                        GeneralPurposeCard(
                          title: l10n.didYouKnow,
                          description: cluster.didYouKnow,
                          textStyle: Theme.of(context).textTheme.bodyLarge,
                          titleStyle: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                          bgColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),

                  // Action items
                  if (cluster.userActionItems.isNotEmpty)
                    Card(
                      elevation: 0,
                      color: Color.alphaBlend(
                        Theme.of(
                          context,
                        ).colorScheme.tertiary.withValues(alpha: 0.3),
                        Theme.of(context).colorScheme.surface,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              l10n.actionItems,
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...cluster.userActionItems.map((actionItem) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BulletPoint(
                                    text: actionItem.trim(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    bulletSize: 8,
                                    bulletColor:
                                        Theme.of(context).colorScheme.primary,
                                    spacing: 8,
                                  ),
                                ],
                              );
                            }),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),

                  // Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.footer,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          // fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
