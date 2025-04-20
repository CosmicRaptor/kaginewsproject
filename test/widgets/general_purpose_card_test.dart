import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kaginewsproject/widgets/general_purpose_card.dart';

void main() {
  testWidgets('renders title and description', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GeneralPurposeCard(
            title: 'Test Title',
            description: 'Test Description',
          ),
        ),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
  });

  testWidgets('renders (via domain) when urlDomain is provided', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GeneralPurposeCard(
            title: 'Title',
            description: 'More Info',
            urlDomain: 'example.com',
          ),
        ),
      ),
    );

    expect(find.textContaining('via example.com'), findsOneWidget);
  });

  testWidgets('applies custom text styles', (tester) async {
    const titleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    const descStyle = TextStyle(color: Colors.green);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GeneralPurposeCard(
            title: 'Styled Title',
            description: 'Styled Description',
            titleStyle: titleStyle,
            textStyle: descStyle,
          ),
        ),
      ),
    );

    final titleWidget = tester.widget<Text>(find.text('Styled Title'));

    expect(titleWidget.style?.fontWeight, FontWeight.bold);
    expect(titleWidget.style?.fontSize, 20);
  });
}
