import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kaginewsproject/l10n/l10n.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/widgets/shimmer_loader_home_screen.dart';

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
                imageShimmer(
                  width: double.infinity,
                  height: 200,
                  imgUrl: widget.newsCluster.articles[0].image,
                  imgCaption: widget.newsCluster.articles[0].imageCaption,
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
                    const SizedBox(height: 5),
                    if (widget.newsCluster.location.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          Text(
                            widget.newsCluster.location,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[400],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 15),
                    Text(widget.newsCluster.title),
                    // const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.push('/news/', extra: widget.newsCluster);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Text(
                            '${l10n.readMore}...',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
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
