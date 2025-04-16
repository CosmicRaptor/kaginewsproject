import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:kaginewsproject/enums/event_type_enum.dart';

import '../models/onthisday_model.dart';

class OnthisdayViewModel {
  final OnThisDay events;
  const OnthisdayViewModel({required this.events});

  TextSpan htmlToTextSpan(
    String html, {
    TextStyle? baseStyle,
    void Function(String href)? onLinkTap,
  }) {
    final root = parseFragment(html);

    return TextSpan(
      style: baseStyle,
      children: _buildSpans(
        root.nodes,
        baseStyle ?? const TextStyle(),
        onLinkTap,
      ),
    );
  }

  List<InlineSpan> _buildSpans(
    List<dom.Node> nodes,
    TextStyle style,
    void Function(String href)? onLinkTap,
  ) {
    List<InlineSpan> spans = [];

    for (var node in nodes) {
      if (node is dom.Text) {
        spans.add(TextSpan(text: node.text));
      } else if (node is dom.Element) {
        if (node.localName == 'a') {
          final href = node.attributes['href'] ?? '';
          final children = _buildSpans(
            node.nodes,
            style.copyWith(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            onLinkTap,
          );
          spans.add(
            TextSpan(
              children: children,
              style: style.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer(
                  supportedDevices: {PointerDeviceKind.touch},
                )
                ..onTap = () {
                  if (onLinkTap != null) onLinkTap(href);
                },
            ),
          );
        } else if (node.localName == 'b') {
          spans.addAll(
            _buildSpans(
              node.nodes,
              style.copyWith(fontWeight: FontWeight.bold),
              onLinkTap,
            ),
          );
        } else {
          // For unhandled tags, treat as normal text
          spans.addAll(_buildSpans(node.nodes, style, onLinkTap));
        }
      }
    }

    return spans;
  }

  List<OnThisDayEvent> getEvents() {
    return events.events
        .where((event) => event.type == EventType.event)
        .toList();
  }

  List<OnThisDayEvent> getPeople() {
    return events.events
        .where((event) => event.type == EventType.people)
        .toList();
  }

  static String? getTitle(String content) {
    final root = parse(content);
    // Extract the first <a> tag content
    final firstATag = root.querySelector('a');

    if (firstATag != null) {
      return firstATag.text;
    } else {
      return null;
    }
  }
}
