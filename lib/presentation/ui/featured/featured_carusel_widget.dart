import 'package:era_developers_test_flutter/presentation/ui/featured/featured_widget.dart';
import 'package:flutter/material.dart';
import '../../../repositories/news/mock_news_repository.dart';
import '../../../repositories/news/models/article.dart';



class FeaturedCarouselWidget extends StatefulWidget {
  const FeaturedCarouselWidget({Key? key}) : super(key: key);

  @override
  _FeaturedCarouselWidgetState createState() => _FeaturedCarouselWidgetState();
}

class _FeaturedCarouselWidgetState extends State<FeaturedCarouselWidget> {
  final PageController _pageController = PageController(viewportFraction: 1);
  late MockNewsRepository mockNewsRepository;

  @override
  void initState() {
    super.initState();
    mockNewsRepository = MockNewsRepository();
  }

  @override
  void dispose() {
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
          child: Text('Featured', style: Theme.of(context).textTheme.headlineLarge,),
        ),
        const SizedBox(height: 20,),
        FutureBuilder<List<Article>>(
          future: mockNewsRepository.getFeaturedArticles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Ошибка при загрузке новостей',));
            } else {
              return SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return FeaturedWidget(
                      article: snapshot.data![index],
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
