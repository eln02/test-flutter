import 'package:era_developers_test_flutter/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../repositories/news/mock_news_repository.dart';
import '../../repositories/news/models/article.dart';

class NewsPage extends StatefulWidget {
  final String id;

  const NewsPage({Key? key, required this.id}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late MockNewsRepository mockNewsRepository;

  @override
  void initState() {
    super.initState();
    mockNewsRepository = MockNewsRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: FutureBuilder<Article>(
        future: mockNewsRepository.getArticle(widget.id),
        builder: (BuildContext context, AsyncSnapshot<Article> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _newsPic(snapshot.data!.imageUrl, snapshot.data!.title),
                  _text(snapshot.data!.description)
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _newsPic(String imageUrl, String title) {
    return SizedBox(
      height: 495,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
          Positioned(
            top: 43,
            left: 16,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 24,
                width: 24,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    'assets/arrow_back.svg',
                    height: 24,
                    width: 9,
                    fit: BoxFit.scaleDown,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 48,
            right: 48,
            child: Text(title,
                style: Theme.of(context).textTheme.displayLarge,
                softWrap: true),
          ),
        ],
      ),
    );
  }

  Widget _text(String? description) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
        child: Text(TextUtil.splitIntoParagraphs(description)));
  }
}
