import 'package:flutter/material.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';

class SourcesWidget extends StatelessWidget {
  final List<NewsDomains> sources;
  const SourcesWidget({super.key, required this.sources});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: sources.length,
      itemBuilder: (context, index) {
        final source = sources[index];
        return SizedBox(
          // width: 50,
          // height: 10,
          child: Image.network(source.favicon, fit: BoxFit.fill),
        );
      },
    );
  }
}
