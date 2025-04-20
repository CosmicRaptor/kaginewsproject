import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../models/category_articles_stuff.dart';
import 'news_card.dart';

class HomeWidget extends StatelessWidget {
  final NewsCategoryDetail detail;
  const HomeWidget({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...detail.clusters.map((cluster) => NewsCard(newsCluster: cluster, category: detail.category,)),
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
    );
  }
}
