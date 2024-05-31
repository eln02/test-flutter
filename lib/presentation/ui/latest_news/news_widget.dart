import 'package:era_developers_test_flutter/presentation/ui/news_page.dart';
import 'package:flutter/material.dart';
import '../../../utils/date_util.dart';
import '../../../repositories/news/models/article.dart';

class NewsWidget extends StatelessWidget {
  final Article article;

  const NewsWidget({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewsPage(id: article.id)),
      );},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9.0),
          boxShadow: const [
            BoxShadow(
              offset: Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 0,
              color: Color(0xFFFFFFFF),
            ),
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 20,
              spreadRadius: 0,
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
          ],
        ),
        height: 103,
        child: Row(
          children: [
            Container(
              height: 60,
              width: 90,
              margin: const EdgeInsets.only(top: 20, left: 20, bottom: 23, right: 23),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFFC4C4C4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin:
                const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title,
                        style: Theme.of(context).textTheme.displayMedium,
                        softWrap: true),
                    const Expanded(child: SizedBox(),),
                    Text(DateUtil.ago(article.publicationDate),
                        style: Theme.of(context).textTheme.displaySmall,
                        softWrap: true),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}