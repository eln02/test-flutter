import 'package:era_developers_test_flutter/presentation/ui/latest_news/news_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/featured_bloc.dart';

class NewsListWidget extends StatefulWidget {
  const NewsListWidget({Key? key}) : super(key: key);

  @override
  _NewsListWidgetState createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28),
      child: BlocBuilder<ArticlesBloc, ArticleState>(
        builder: (context, state) {
          if (state.latestArticles.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.latestArticles.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: NewsWidget(article: state.latestArticles[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
