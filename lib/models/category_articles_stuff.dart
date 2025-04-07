class NewsCategoryDetail {
  final String category;
  final int timestamp;
  final int read;
  final List<NewsCluster> clusters;

  NewsCategoryDetail({
    required this.category,
    required this.timestamp,
    required this.read,
    required this.clusters,
  });

  factory NewsCategoryDetail.fromJson(Map<String, dynamic> json) {
    return NewsCategoryDetail(
      category: json['category'],
      timestamp: json['timestamp'],
      read: json['read'],
      clusters: (json['clusters'] as List)
          .map((item) => NewsCluster.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'timestamp': timestamp,
      'read': read,
      'clusters': clusters.map((item) => item.toJson()).toList(),
    };
  }
}

class NewsCluster {
  final int clusterNumber;
  final int uniqueDomains;
  final int numberOfTitles;
  final String category;
  final String title;
  final String shortSummary;
  final String didYouKnow;
  final List<String> talkingPoints;
  final String quote;
  final String quoteAuthor;
  final String quoteSourceUrl;
  final String quoteSourceDomain;
  final String location;
  final List<NewsPerspective> perspectives;

  NewsCluster({
    required this.clusterNumber,
    required this.uniqueDomains,
    required this.numberOfTitles,
    required this.category,
    required this.title,
    required this.shortSummary,
    required this.didYouKnow,
    required this.talkingPoints,
    required this.quote,
    required this.quoteAuthor,
    required this.quoteSourceUrl,
    required this.quoteSourceDomain,
    required this.location,
    required this.perspectives,
  });

  factory NewsCluster.fromJson(Map<String, dynamic> json) {
    return NewsCluster(
      clusterNumber: json['cluster_number'],
      uniqueDomains: json['unique_domains'],
      numberOfTitles: json['number_of_titles'],
      category: json['category'],
      title: json['title'],
      shortSummary: json['short_summary'],
      didYouKnow: json['did_you_know'],
      talkingPoints: List<String>.from(json['talking_points']),
      quote: json['quote'],
      quoteAuthor: json['quote_author'],
      quoteSourceUrl: json['quote_source_url'],
      quoteSourceDomain: json['quote_source_domain'],
      location: json['location'],
      perspectives: (json['perspectives'] as List)
          .map((item) => NewsPerspective.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cluster_number': clusterNumber,
      'unique_domains': uniqueDomains,
      'number_of_titles': numberOfTitles,
      'category': category,
      'title': title,
      'short_summary': shortSummary,
      'did_you_know': didYouKnow,
      'talking_points': talkingPoints,
      'quote': quote,
      'quote_author': quoteAuthor,
      'quote_source_url': quoteSourceUrl,
      'quote_source_domain': quoteSourceDomain,
      'location': location,
      'perspectives': perspectives.map((item) => item.toJson()).toList(),
    };
  }
}

class NewsPerspective {
  final String text;
  final List<NewsSource> sources;

  NewsPerspective({
    required this.text,
    required this.sources,
  });

  factory NewsPerspective.fromJson(Map<String, dynamic> json) {
    return NewsPerspective(
      text: json['text'],
      sources: (json['sources'] as List)
          .map((item) => NewsSource.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sources': sources.map((item) => item.toJson()).toList(),
    };
  }
}

class NewsSource {
  final String name;
  final String url;

  NewsSource({
    required this.name,
    required this.url,
  });

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
