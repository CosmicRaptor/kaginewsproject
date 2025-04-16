import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/models/onthisday_model.dart';
import 'package:kaginewsproject/widgets/footer_text.dart';

import '../providers/viewmodel_providers.dart';
import 'onthisday_timeline_stepper.dart';
import 'thisday_people_card.dart';

class OnthisdayWidget extends ConsumerWidget {
  final OnThisDay events;
  const OnthisdayWidget({super.key, required this.events});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(onthisdayVMProvider(events));
    final people = vm.getPeople();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          // Timeline of events
          Text('Events', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          OnthisdayTimelineStepper(events: events),
          const SizedBox(height: 20),

          // Timeline of people
          Text('People', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  people.map((event) {
                    return ThisdayPeopleCard(
                      event: event,
                      span: vm.htmlToTextSpan(
                        event.content,
                        onLinkTap: (ref) {},
                        baseStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Footer
          const FooterText(),
        ],
      ),
    );
  }
}
