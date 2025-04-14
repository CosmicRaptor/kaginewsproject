import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/models/onthisday_model.dart';
import 'package:kaginewsproject/providers/viewmodel_providers.dart';
import 'package:kaginewsproject/widgets/custom_stepper.dart';

class OnthisdayTimelineStepper extends ConsumerWidget {
  final OnThisDay events;
  const OnthisdayTimelineStepper({super.key, required this.events});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(onthisdayVMProvider(events));
    final eventsList = vm.getEvents();
    return ModifiedStepper(
      type: ModifiedStepperType.vertical,
      currentStep: 0,
      physics: const NeverScrollableScrollPhysics(),
      controlsBuilder: (context, _) => const SizedBox.shrink(), // Hides buttons
      onStepTapped: (_) {}, // Disables tap
      onStepContinue: () {}, // Disables continue
      onStepCancel: () {}, // Disables cancel
      steps:
          eventsList.map((event) {
            final textSpan = vm.htmlToTextSpan(
              event.content,
              onLinkTap: (href) {},
              baseStyle: Theme.of(context).textTheme.bodySmall,
            );
            return ModifiedStep(
              title: Text(
                event.year,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              content: RichText(text: textSpan),
              isActive: true,
              state: ModifiedStepState.complete,
            );
          }).toList(),
    );
  }
}
