import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool haptics(ScrollNotification scrollNotification) {
  final metrics = scrollNotification.metrics;
  if (scrollNotification is ScrollEndNotification) {
    if (metrics.pixels <= metrics.minScrollExtent) {
      HapticFeedback.lightImpact();
    } else if (metrics.pixels >= metrics.maxScrollExtent) {
      HapticFeedback.heavyImpact();
    }
  }
  return false;
}
