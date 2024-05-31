import 'package:era_developers_test_flutter/presentation/ui/latest_news/news_widget.dart';
import 'package:era_developers_test_flutter/repositories/news/repository.dart';
import 'package:flutter/material.dart';

class NewsListWidget extends StatefulWidget {
  const NewsListWidget({Key? key}) : super(key: key);

  @override
  _NewsListWidgetState createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  late MockNewsRepository mockNewsRepository;

  @override
  void initState() {
    super.initState();
    mockNewsRepository = MockNewsRepository();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Latest news', style: Theme.of(context).textTheme.headlineLarge,),
          const SizedBox(height: 20,),
          FutureBuilder<List<Article>>(
            future: mockNewsRepository.getLatestArticles(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Ошибка при загрузке новостей',));
              } else {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: NewsWidget(article: snapshot.data![index]),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}



