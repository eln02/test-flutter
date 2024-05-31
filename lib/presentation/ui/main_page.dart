import 'package:era_developers_test_flutter/presentation/ui/app_bar.dart';
import 'package:era_developers_test_flutter/presentation/ui/featured/featured_carusel_widget.dart';
import 'package:era_developers_test_flutter/presentation/ui/latest_news/news_list_widget.dart';
import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: MainAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FeaturedCarouselWidget(),
              SizedBox(height: 20,),
              NewsListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

