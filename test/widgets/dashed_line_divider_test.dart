import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaginewsproject/widgets/dashed_line_divider.dart';

void main() {
  testWidgets('DashedLineDivider test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomPaint(
            key: Key('dashed_line_divider'),
            size: Size(200, 1),
            painter: DashedLineDivider(),
          ),
        ),
      ),
    );
    final dashedLineFinder = find.byKey(const Key('dashed_line_divider'));
    expect(dashedLineFinder, findsOneWidget);

    // Verify the size of the dashed line
    final dashedLine = tester.widget<CustomPaint>(dashedLineFinder);
    expect(dashedLine.size.width, 200);
    expect(dashedLine.size.height, 1);
  });
}
