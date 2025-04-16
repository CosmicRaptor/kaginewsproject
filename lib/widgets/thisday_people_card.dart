import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/l10n/l10n.dart';
import 'package:kaginewsproject/models/onthisday_model.dart';
import 'package:kaginewsproject/providers/api_provider.dart';
import 'package:kaginewsproject/providers/viewmodel_providers.dart';

class ThisdayPeopleCard extends ConsumerWidget {
  final OnThisDayEvent event;
  final TextSpan span;
  const ThisdayPeopleCard({super.key, required this.event, required this.span});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final title = ref.watch(onthisdayWikipediaTitleProvider(event.content));
    final width = MediaQuery.of(context).size.width;
    return title != null
        ? ref
            .watch(getWikipediaSummaryProvider(title))
            .when(
              error: (error, stacktrace) {
                return Center(child: Text(l10n.errorOccured));
              },
              loading:
                  () => const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  ),
              data: (data) {
                return Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          event.year,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data.thumbnailUrl != null &&
                                data.thumbnailUrl!.isNotEmpty)
                              CircleAvatar(
                                radius: 20,
                                child: Image.network(
                                  data.thumbnailUrl!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: width * 0.3,
                              child: RichText(
                                text: span,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
        : const SizedBox();
  }
}
