import '../enums/event_type_enum.dart';

class OnThisDay {
  final int timestamp;
  final List<OnThisDayEvent> events;

  OnThisDay({required this.timestamp, required this.events});

  factory OnThisDay.fromJson(Map<String, dynamic> json) {
    return OnThisDay(
      timestamp: json['timestamp'],
      events:
          (json['events'] as List)
              .map((item) => OnThisDayEvent.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'events': events.map((item) => item.toJson()).toList(),
    };
  }
}

class OnThisDayEvent {
  final String year;
  final String content;
  final double sortYear;
  final EventType type;

  OnThisDayEvent({
    required this.year,
    required this.content,
    required this.sortYear,
    required this.type,
  });

  factory OnThisDayEvent.fromJson(Map<String, dynamic> json) {
    return OnThisDayEvent(
      year: json['year'],
      content: json['content'],
      // I have no idea why, but this is how it works.
      sortYear: double.parse(json['sort_year'].toString()),
      type: EventType.values.firstWhere((e) => e.name == json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'content': content,
      'sort_year': sortYear,
      'type': type.name,
    };
  }
}
