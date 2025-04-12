import 'package:flutter/material.dart';
import '../util/shimmer_effects.dart';

class ShimmerLoaderHomeScreen extends StatelessWidget {
  final bool loadAppBar;
  const ShimmerLoaderHomeScreen({super.key, required this.loadAppBar});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget shimmerCardBlock() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerBox(width: width, height: 300, context: context),
          const SizedBox(height: 10),
          shimmerBox(width: width, height: 20, context: context),
          const SizedBox(height: 5),
          shimmerBox(width: width * 0.5, height: 20, context: context),
        ],
      );
    }

    return Shimmer(
      linearGradient: shimmerGradient(context),
      child: Container(
        color: Theme.of(context).canvasColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (loadAppBar) ...[
                  ShimmerLoading(
                    isLoading: true,
                    child: shimmerBox(
                      width: width,
                      height: 70,
                      context: context,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                ShimmerLoading(isLoading: true, child: shimmerCardBlock()),
                const SizedBox(height: 20),
                ShimmerLoading(isLoading: true, child: shimmerCardBlock()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget shimmerBox({
  required double width,
  required double height,
  required BuildContext context,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

Widget imageShimmer({
  required double width,
  required double height,
  required String imgUrl,
  String? imgCaption,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.network(
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Shimmer(
          linearGradient: shimmerGradient(context),
          child: ShimmerLoading(
            isLoading: true,
            child: shimmerBox(width: width, height: height, context: context),
          ),
        );
      },
      imgUrl,
      semanticLabel: imgCaption,
      fit: BoxFit.cover,
      width: width,
      height: height,
    ),
  );
}
