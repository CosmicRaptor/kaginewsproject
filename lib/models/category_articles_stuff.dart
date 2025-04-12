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
      clusters:
          (json['clusters'] as List)
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
  final List<NewsArticle> articles;
  final List<NewsDomains> domains;
  final String historicalBackground;
  final String humanitarianImpact;
  final List<String> technicalDetails;
  final String businessAngleText;
  final List<String> businessAnglePoints;
  final List<String> internationalReactions;
  final List<String> timeline;

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
    required this.articles,
    required this.domains,
    required this.historicalBackground,
    required this.humanitarianImpact,
    required this.technicalDetails,
    required this.businessAngleText,
    required this.businessAnglePoints,
    required this.internationalReactions,
    required this.timeline,
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
      historicalBackground: json['historical_background'],
      humanitarianImpact: json['humanitarian_impact'],
      technicalDetails:
          json['technical_details'].isNotEmpty
              ? List<String>.from(json['technical_details'])
              : [],
      businessAngleText: json['business_angle_text'],
      businessAnglePoints:
          json['business_angle_points'].isNotEmpty
              ? List<String>.from(json['business_angle_points'])
              : [],
      internationalReactions:
          json['international_reactions'].isNotEmpty
              ? List<String>.from(json['international_reactions'])
              : [],
      perspectives:
          (json['perspectives'] as List)
              .map((item) => NewsPerspective.fromJson(item))
              .toList(),
      timeline:
          json['timeline'].isNotEmpty
              ? List<String>.from(json['timeline'])
              : [],
      articles:
          (json['articles'] as List)
              .map((item) => NewsArticle.fromJson(item))
              .toList(),
      domains:
          (json['domains'] as List)
              .map((item) => NewsDomains.fromJson(item))
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
      'historical_background': historicalBackground,
      'humanitarian_impact': humanitarianImpact,
      'perspectives': perspectives.map((item) => item.toJson()).toList(),
      'articles': articles.map((item) => item.toJson()).toList(),
      'domains': domains.map((item) => item.toJson()).toList(),
      'technical_details': technicalDetails,
    };
  }
}

class NewsPerspective {
  final String text;
  final List<NewsSource> sources;

  NewsPerspective({required this.text, required this.sources});

  factory NewsPerspective.fromJson(Map<String, dynamic> json) {
    return NewsPerspective(
      text: json['text'],
      sources:
          (json['sources'] as List)
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

  NewsSource({required this.name, required this.url});

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}

class NewsArticle {
  final String title;
  final String link;
  final String domain;
  final DateTime date;
  final String image;
  final String imageCaption;

  NewsArticle({
    required this.title,
    required this.link,
    required this.domain,
    required this.date,
    required this.image,
    required this.imageCaption,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      link: json['link'],
      domain: json['domain'],
      date: DateTime.parse(json['date']),
      image: json['image'],
      imageCaption: json['image_caption'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'domain': domain,
      'date': date.toIso8601String(),
      'image': image,
      'image_caption': imageCaption,
    };
  }
}

class NewsDomains {
  final String name;
  final String favicon;

  NewsDomains({required this.name, required this.favicon});

  factory NewsDomains.fromJson(Map<String, dynamic> json) {
    return NewsDomains(name: json['name'], favicon: json['favicon']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'favicon': favicon};
  }
}
