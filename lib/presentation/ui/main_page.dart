import 'package:era_developers_test_flutter/presentation/ui/app_bar.dart';
import 'package:era_developers_test_flutter/presentation/ui/featured/featured_carusel_widget.dart';
import 'package:era_developers_test_flutter/presentation/ui/latest_news/news_list_widget.dart';
import 'package:flutter/material.dart';
import '../../repositories/news/models/article.dart';
import '../bloc/featured_bloc.dart';
import 'latest_news/news_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  bool _widgetType = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        _widgetType = true;
      } else {
        _widgetType = false;
      }
    } else {
      _widgetType = _scrollController.offset < 0;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: const MainAppBar(),
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.delta.dy > 0) {
              setState(() {
                _widgetType = true;
              });
            } else if (details.delta.dy < 0) {
              setState(() {
                _widgetType = false;
              });
            }
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                BlocBuilder<ArticlesBloc, ArticleState>(
                  builder: (context, state) {
                    if (state.articles.isNotEmpty &&
                        state.currentArticle != null) {
                      return AnimatedCrossFade(
                        firstChild: const FeaturedCarouselWidget(),
                        secondChild: _widget(state.currentArticle!),
                        crossFadeState: _widgetType
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 500),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                const NewsListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _widget(Article article) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, left: 28, right: 28),
      child: NewsWidget(article: article),
    );
  }
}
