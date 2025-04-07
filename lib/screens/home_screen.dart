import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/providers/api_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref
          .watch(getCategoryProvider('world'))
          .when(
            data: (data) => Center(child: Text(data.toJson().toString())),
            error: (error, stack) {
              if (kDebugMode) {
                print('Error: $error');
                print('Stack: $stack');
              }
              return Center(child: Text('Error: $error'));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
