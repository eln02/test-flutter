import 'package:era_developers_test_flutter/presentation/ui/featured/featured_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/news/models/article.dart';
import '../../bloc/featured_bloc.dart';

class FeaturedCarouselWidget extends StatefulWidget {
  const FeaturedCarouselWidget({Key? key}) : super(key: key);

  @override
  _FeaturedCarouselWidgetState createState() => _FeaturedCarouselWidgetState();
}

class _FeaturedCarouselWidgetState extends State<FeaturedCarouselWidget> {
  final PageController _pageController = PageController(viewportFraction: 1);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    int currentPageIndex = _pageController.page?.round() ?? 0;
    Article? currentArticle =
        context.read<ArticlesBloc>().state.articles[currentPageIndex];
    context.read<ArticlesBloc>().add(SelectArticle(currentArticle));
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            'Featured',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<ArticlesBloc, ArticleState>(
          builder: (context, state) {
            if (state.featuredArticles.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.featuredArticles.length,
                  itemBuilder: (context, index) {
                    return FeaturedWidget(
                      article: state.featuredArticles[index],
                    );
                  },
                ),
              );
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 28, right: 28),
          child: Text(
            'Latest news',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}
