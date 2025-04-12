import 'package:flutter/material.dart';

import 'custom_stepper.dart';

class TimelineStepper extends StatelessWidget {
  final List<String> timeline;
  const TimelineStepper({super.key, required this.timeline});

  @override
  Widget build(BuildContext context) {
    return ModifiedStepper(
      type: ModifiedStepperType.vertical,
      currentStep: 0,
      physics: const NeverScrollableScrollPhysics(),
      controlsBuilder: (context, _) => const SizedBox.shrink(), // Hides buttons
      onStepTapped: (_) {}, // Disables tap
      onStepContinue: () {}, // Disables continue
      onStepCancel: () {}, // Disables cancel
      steps:
          timeline.map((step) {
            final stepArray = step.split('::');
            return ModifiedStep(
              title: Text(
                stepArray[0],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(stepArray[1]),
              isActive: true,
              state: ModifiedStepState.complete,
            );
          }).toList(),
    );
  }
}
