import 'package:flutter/material.dart';
import 'package:kaginewsproject/l10n/l10n.dart';

class FooterText extends StatelessWidget {
  const FooterText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
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
    );
  }
}
