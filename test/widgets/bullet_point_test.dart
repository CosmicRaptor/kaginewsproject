import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaginewsproject/widgets/bullet_point.dart';

void main() {
  testWidgets('BulletPoint renders with default parameters', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: BulletPoint(text: 'Test Bullet'))),
    );

    expect(find.text('Test Bullet'), findsOneWidget);

    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;

    expect(container.constraints, isNotNull);
    expect(decoration.shape, BoxShape.circle);
    expect(decoration.color, Colors.black);
  });

  testWidgets('Applies custom bullet size and color', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BulletPoint(
            text: 'Custom Bullet',
            bulletSize: 12,
            bulletColor: Colors.red,
          ),
        ),
      ),
    );

    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.red);
    expect(container.constraints?.maxWidth, 12);
    expect(container.constraints?.maxHeight, 12);
  });

  testWidgets('Applies custom text style', (tester) async {
    const customStyle = TextStyle(fontSize: 20, color: Colors.green);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BulletPoint(text: 'Styled Text', style: customStyle),
        ),
      ),
    );

    final text = tester.widget<Text>(find.text('Styled Text'));

    expect(text.style?.fontSize, 20);
    expect(text.style?.color, Colors.green);
  });

  testWidgets('Applies correct spacing between bullet and text', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: BulletPoint(text: 'Spaced Text', spacing: 16)),
      ),
    );

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
    expect(sizedBox.width, 16);
  });

  testWidgets('Uses default text style if none is provided', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: BulletPoint(text: 'Default Style Text')),
      ),
    );

    final textWidget = tester.widget<Text>(find.text('Default Style Text'));
    final style = textWidget.style;
    expect(style?.fontFamilyFallback, contains('Noto Color Emoji'));
  });
}
