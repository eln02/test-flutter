import 'package:era_developers_test_flutter/repositories/news/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/news/mock_news_repository.dart';

abstract class ArticleEvent {}

class SelectArticle extends ArticleEvent {
  final Article article;

  SelectArticle(this.article);
}

class MarkAllFeaturedRead extends ArticleEvent {}

class MarkFeaturedReadById extends ArticleEvent {
  final String id;

  MarkFeaturedReadById(this.id);
}

class ArticleState {
  final List<Article> articles;
  final List<Article> featuredArticles;
  final List<Article> latestArticles;
  final Article? currentArticle;

  ArticleState({
    required this.featuredArticles,
    required this.latestArticles,
    required this.articles,
    this.currentArticle,
  });

  ArticleState copyWith({
    List<Article>? articles,
    List<Article>? featuredArticles,
    List<Article>? latestArticles,
    Article? currentArticle,
  }) {
    return ArticleState(
      featuredArticles: featuredArticles ?? this.featuredArticles,
      latestArticles: latestArticles ?? this.latestArticles,
      articles: articles ?? this.articles,
      currentArticle: currentArticle ?? this.currentArticle,
    );
  }
}

class ArticlesBloc extends Bloc<ArticleEvent, ArticleState> {
  final MockNewsRepository mockNewsRepository;

  ArticlesBloc(this.mockNewsRepository)
      : super(ArticleState(
            articles: [],
            currentArticle: null,
            featuredArticles: [],
            latestArticles: [])) {
    on<SelectArticle>((event, emit) {
      emit(state.copyWith(currentArticle: event.article));
    });

    on<MarkAllFeaturedRead>((event, emit) {
      var articles = state.articles
          .map((article) => Article.copyWith(article, readed: true))
          .toList();
      emit(state.copyWith(
          articles: articles,
          currentArticle: Article.copyWith(state.currentArticle!, readed: true),
          featuredArticles: articles.sublist(0, 3),
          latestArticles: articles.sublist(3)));
    });

    on<MarkFeaturedReadById>((event, emit) {
      var updateCurrent = Article.copyWith(state.currentArticle!);
      if (event.id == state.currentArticle?.id){
        updateCurrent = Article.copyWith(state.currentArticle!, readed: true);
      }

      var updatedArticles = state.articles.map((article) {
        if (article.id == event.id) {
          return Article.copyWith(article, readed: true);
        } else {
          return article;
        }
      }).toList();

      emit(state.copyWith(
          articles: updatedArticles,
          currentArticle: updateCurrent,
          featuredArticles: updatedArticles.sublist(0, 3),
          latestArticles: updatedArticles.sublist(3)));
    });

    mockNewsRepository.getLatestArticles().then((articles) {
      if (articles.isNotEmpty) {
        emit(state.copyWith(
            articles: articles,
            currentArticle: articles.first,
            featuredArticles: articles.sublist(0, 3),
            latestArticles: articles.sublist(3)));
      }
    });
  }
}
