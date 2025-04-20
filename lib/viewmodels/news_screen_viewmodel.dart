import 'package:kaginewsproject/models/category_articles_stuff.dart';
import 'package:share_plus/share_plus.dart';

class NewsScreenViewmodel {
  final NewsCluster cluster;
  NewsScreenViewmodel(this.cluster);

  String _getShareText(String category) {
    return "https://kite.kagi.com/?article=$category-${cluster.clusterNumber}";
  }

  void shareArticle(String category) {
    final shareText = _getShareText(category);
    Share.shareUri(Uri.parse(shareText));
  }
}
