import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaginewsproject/enums/event_type_enum.dart';
import 'package:kaginewsproject/models/onthisday_model.dart';
import 'package:kaginewsproject/viewmodels/onthisday_viewmodel.dart';

void main() {
  group('OnthisdayViewModel', () {
    final mockEvents = OnThisDay(
      // Timestamp does not matter for this test
      timestamp: 0000,
      events: [
        OnThisDayEvent(
          year: "2025",
          content: "Test 1",
          sortYear: 2025,
          type: EventType.event,
        ),
        OnThisDayEvent(
          year: "2024",
          content: "Test 2",
          sortYear: 2024,
          type: EventType.people,
        ),
        OnThisDayEvent(
          year: "2023",
          content: "Test 3",
          sortYear: 2023,
          type: EventType.event,
        ),
      ],
    );

    final viewModel = OnthisdayViewModel(inputEvents: mockEvents);

    // Tests for _getEvents
    test('returns only events of type event', () {
      final events = viewModel.events;
      expect(events.length, 2);
      expect(events.every((event) => event.type == EventType.event), isTrue);
    });

    // Tests for _getPeople
    test('returns only events of type people', () {
      final people = viewModel.people;
      expect(people.length, 1);
      expect(people.every((person) => person.type == EventType.people), isTrue);
    });

    // Tests for htmlToTextSpan
    test('converts simple HTML to TextSpan', () {
      final html = '<b>Bold Text</b>';
      final result = viewModel.htmlToTextSpan(html);
      expect(result.children?.length, 1);
      expect(
        (result.children?.first as TextSpan).style?.fontWeight,
        FontWeight.bold,
      );
    });

    test('handles anchor tags with onLinkTap callback', () {
      final html = '<a href="https://example.com">Link</a>';
      String? tappedLink;
      final result = viewModel.htmlToTextSpan(
        html,
        onLinkTap: (href) => tappedLink = href,
      );
      final recognizer =
          (result.children?.first as TextSpan).recognizer
              as TapGestureRecognizer;
      recognizer.onTap!();
      expect(tappedLink, 'https://example.com');
    });

    test('ignores unsupported tags and treats them as plain text', () {
      final html = '<unsupported>Text</unsupported>';
      final result = viewModel.htmlToTextSpan(html);
      expect(result.children?.length, 1);
      expect((result.children?.first as TextSpan).text, 'Text');
    });

    // Tests for getTitle
    test('extracts the text of the first <a> tag', () {
      final html = '<a>Title</a>';
      final title = OnthisdayViewModel.getTitle(html);
      expect(title, 'Title');
    });

    test('returns null if no <a> tag is present', () {
      final html = '<div>No Title</div>';
      final title = OnthisdayViewModel.getTitle(html);
      expect(title, isNull);
    });
  });
}
