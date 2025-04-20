import 'package:flutter/material.dart';
import '../models/category_articles_stuff.dart';
import 'shimmer_loader.dart';

class NewsImageWithCaption extends StatelessWidget {
  final NewsArticle article;
  const NewsImageWithCaption({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageShimmer(
              width: double.infinity,
              height: 200,
              imgUrl: article.image,
              imgCaption: article.imageCaption,
            ),
          ),
        ),
        if (article.imageCaption.isNotEmpty)
          Text(
            article.imageCaption,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(fontStyle: FontStyle.italic),
          ),
      ],
    );
  }
}
