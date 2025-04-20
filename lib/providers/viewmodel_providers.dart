import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:kaginewsproject/models/onthisday_model.dart';
import 'package:kaginewsproject/viewmodels/news_screen_viewmodel.dart';

import '../viewmodels/home_screen_viewmodel.dart';
import '../viewmodels/onthisday_viewmodel.dart';

// Creating providers for all viewmodels to allow expansion in the future and allow data parsing at provider level if needed.

final onthisdayVMProvider = Provider.family<OnthisdayViewModel, OnThisDay>((
  ref,
  events,
) {
  final onthisday = OnthisdayViewModel(inputEvents: events);
  return onthisday;
});

final onthisdayWikipediaTitleProvider = Provider.family<String?, String>((
  ref,
  input,
) {
  return OnthisdayViewModel.getTitle(input);
});

final homeVMProvider = ChangeNotifierProvider((ref) => HomeViewModel(ref));

final newsVMProvider = Provider.family<NewsScreenViewmodel, NewsCluster>((ref, cluster){
  return NewsScreenViewmodel(cluster);
});
