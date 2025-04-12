import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralPurposeCard extends StatelessWidget {
  final String title;
  final String description;
  final String? url;
  final String? urlDomain;
  final Color? bgColor;
  final TextStyle? textStyle;
  final TextStyle? titleStyle;

  const GeneralPurposeCard({
    super.key,
    required this.title,
    required this.description,
    this.url,
    this.urlDomain,
    this.bgColor,
    this.textStyle,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: bgColor ?? Theme.of(context).colorScheme.surfaceContainerHighest,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                title,
                style: titleStyle ??
                    Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  if (url != null) {
                    launchUrl(Uri.parse(url!));
                  }
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: description,
                        style: textStyle ??
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue, // Default color for description
                            ),
                      ),
                      if (urlDomain != null)
                        TextSpan(
                          text: " (via $urlDomain)",
                          style: const TextStyle(
                            color: Colors.blue, // Always blue for "via domain"
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
