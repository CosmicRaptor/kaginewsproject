import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralPurposeCard extends StatelessWidget {
  final String title;
  final String description;
  final String? url;
  final String? urlDomain;
  const GeneralPurposeCard({
    super.key,
    required this.title,
    required this.description,
    this.url,
    this.urlDomain,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                child: Text(
                  "$description ${urlDomain != null ? "(via $urlDomain)" : ""}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
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
