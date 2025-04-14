class WikiSummary {
  final String title;
  final String? displayTitle;
  final String? description;
  final String? extract;
  final String? extractHtml;
  final String? thumbnailUrl;
  final String? originalImageUrl;
  final String? pageUrl;

  WikiSummary({
    required this.title,
    this.displayTitle,
    this.description,
    this.extract,
    this.extractHtml,
    this.thumbnailUrl,
    this.originalImageUrl,
    this.pageUrl,
  });

  factory WikiSummary.fromJson(Map<String, dynamic> json) {
    return WikiSummary(
      title: json['title'] ?? '',
      displayTitle: json['displaytitle'],
      description: json['description'],
      extract: json['extract'],
      extractHtml: json['extract_html'],
      thumbnailUrl: json['thumbnail']?['source'],
      originalImageUrl: json['originalimage']?['source'],
      pageUrl: json['content_urls']?['desktop']?['page'],
    );
  }
}
