import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaginewsproject/l10n/l10n.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/widgets/quote_text.dart';

class NewsCard extends StatefulWidget {
  final NewsCluster newsCluster;
  const NewsCard({super.key, required this.newsCluster});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isQuoteVisible = false;
  void toggleQuoteVisibility() {
    HapticFeedback.selectionClick();
    setState(() {
      isQuoteVisible = !isQuoteVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.newsCluster.articles[0].image.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.newsCluster.articles[0].image,
                    semanticLabel: widget.newsCluster.articles[0].imageCaption,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.newsCluster.category,
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 15),
                    Text(widget.newsCluster.title),
                    // const SizedBox(height: 5),
                    if (isQuoteVisible)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: QuoteText(cluster: widget.newsCluster),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: toggleQuoteVisibility,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Text(
                            '${isQuoteVisible ? l10n.readLess : l10n.readMore}...',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
