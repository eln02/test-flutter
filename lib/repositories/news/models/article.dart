class Article {
  const Article({
    required this.id,
    required this.title,
    required this.publicationDate,
    required this.imageUrl,
    this.readed = false,
    this.description,
  });

  final String id;
  final String title;
  final DateTime publicationDate;
  final String imageUrl;
  final bool readed;
  final String? description;

  factory Article.copyWith(Article oldArticle, {bool? readed}) {
    return Article(
      id: oldArticle.id,
      title: oldArticle.title,
      publicationDate: oldArticle.publicationDate,
      imageUrl: oldArticle.imageUrl,
      readed: readed?? oldArticle.readed,
      description: oldArticle.description,
    );
  }
}
