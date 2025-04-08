import 'package:flutter/material.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';

class QuoteText extends StatelessWidget {
  final NewsCluster cluster;
  const QuoteText({super.key, required this.cluster});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cluster.quote,
          style: const TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
        Text(
          "- ${cluster.quoteAuthor}",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
