import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/news/models/article.dart';
import '../../bloc/featured_bloc.dart';
import '../news_page.dart';

class FeaturedWidget extends StatelessWidget {
  final Article article;

  const FeaturedWidget({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ArticlesBloc>(context)
            .add(MarkFeaturedReadById(article.id));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsPage(id: article.id)),
        );
      },
      child: Container(
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 28),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(article.imageUrl),
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
              bottom: 40,
              left: 20,
              right: 20,
              child: Text(article.title,
                  style: Theme.of(context).textTheme.displayLarge,
                  softWrap: true),
            ),
          ],
        ),
      ),
    );
  }
}
