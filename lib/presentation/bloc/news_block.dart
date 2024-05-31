import 'package:era_developers_test_flutter/repositories/news/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/news/mock_news_repository.dart';

abstract class NewsEvent {}

class MarkAllRead extends NewsEvent {}

class MarkReadById extends NewsEvent {
  final String id;

  MarkReadById(this.id);
}

class NewsBloc extends Bloc<NewsEvent, List<Article>> {
  final MockNewsRepository mockNewsRepository;

  NewsBloc(this.mockNewsRepository) : super([]) {
    on<MarkAllRead>((event, emit) {
      var news = state
          .map((article) => Article.copyWith(article, readed: true))
          .toList();
      emit(news);
    });

    on<MarkReadById>((event, emit) {
      var updatedArticles = state.map((article) {
        if (article.id == event.id) {
          return Article.copyWith(article, readed: true);
        } else {
          return article;
        }
      }).toList();

      emit(updatedArticles);
    });

    mockNewsRepository.getLatestArticles().then((articles) => emit(articles));
  }
}
