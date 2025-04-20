import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kaginewsproject/l10n/l10n.dart'; // contains extension & AppLocalizations
import 'package:kaginewsproject/widgets/footer_text.dart';

void main() {
  testWidgets('FooterText displays localized footer text (en)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: FooterText(key: Key('footer_text'))),
      ),
    );

    await tester.pumpAndSettle();

    final context = tester.element(find.byKey(const Key('footer_text')));
    final localizedFooter = context.l10n.footer;

    expect(find.text(localizedFooter), findsOneWidget);
  });
}
