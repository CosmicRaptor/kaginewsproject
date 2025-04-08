import 'package:flutter/material.dart';
import '../util/shimmer_effects.dart';

class ShimmerLoaderHomeScreen extends StatelessWidget {
  final bool loadAppBar;
  const ShimmerLoaderHomeScreen({super.key, required this.loadAppBar});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget shimmerBox({required double width, required double height}) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    Widget shimmerCardBlock() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerBox(width: width, height: 300),
          const SizedBox(height: 10),
          shimmerBox(width: width, height: 20),
          const SizedBox(height: 5),
          shimmerBox(width: width * 0.5, height: 20),
        ],
      );
    }

    return Shimmer(
      linearGradient: shimmerGradient,
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
                    child: shimmerBox(width: width, height: 70),
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
